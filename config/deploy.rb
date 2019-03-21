
#-----------------------------------------------------------------------
# 設定ファイルの書き方については、Capistranoの公式ドキュメントを参照してください。
# http://capistranorb.com/documentation/getting-started/configuration/
#-----------------------------------------------------------------------

lock "3.11.0"

#---------------------------------
# ご自身の環境に合わせて修正が必要です。
#---------------------------------
set :repo_url, "https://github.com/Ikasuke/bosai_app_dev.git"

# base
set :application, "RailsSampleApp"
set :branch, "production"
set :user, "admin"
set :deploy_to, "/opt/#{fetch(:application)}"
set :rbenv_ruby, File.read(".ruby-version").strip
set :pty, false
set :use_sudo, false
set :stage, :production
set :deploy_via, :remote_cache
set :linked_dirs, fetch(:linked_dirs, []).push("log", "tmp/pids", "tmp/cache", "tmp/sockets",
                                               "vendor/bundle", "public/system", "public/uploads")
set :linked_files, fetch(:linked_files, []).push("config/database.yml", "config/credentials.yml.enc", "config/master.key")

# puma
set :puma_threads, [4, 16]
set :puma_workers, 0
set :puma_bind, "unix://#{shared_path}/tmp/sockets/puma.sock"
set :puma_state, "#{shared_path}/tmp/pids/puma.state"
set :puma_pid, "#{shared_path}/tmp/pids/puma.pid"
set :puma_access_log, "#{release_path}/log/puma.error.log"
set :puma_error_log, "#{release_path}/log/puma.access.log"
set :puma_preload_app, true

# sidekiq
set :sidekiq_config, "#{current_path}/config/sidekiq.yml"

#whenever
set :whenever_identifier, -> { "#{fetch(:application)}_#{fetch(:stage)}" }
set :whenever_roles, -> { :app }

#nginx
set :nginx_use_ssl, true
set :nginx_server_name, "bosai-stocker.com"
set :nginx_ssl_certificate, "/etc/pki/nginx/bosai-stocker.com.chained.cert"
set :nginx_ssl_certificate_key, "/etc/pki/nginx/bosai-stocker.com.key"
#set :nginx_config_name about=> RailsSamplApp_production
set :nginx_ssl_protocol, "TLSv1 TLSv1.1 TLSv1.2"
set :nginx_ssl_ciphers, "EECDH+AESGCM:EDH+AESGCM:AES256+EECDH:AES256+EDH"

namespace :puma do
  desc "Create Directories for Puma Pids and Socket"
  task :make_dirs do
    on roles(:app) do
      execute "mkdir #{shared_path}/tmp/sockets -p"
      execute "mkdir #{shared_path}/tmp/pids -p"
    end
  end

  before :start, :make_dirs
end

namespace :redis do
  %w[start stop restart].each do |command|
    desc "#{command} redis"
    task command do
      on roles(:app) do
        sudo "service redis #{command}"
      end
    end
  end
end

namespace :deploy do
  desc "Make sure local git is in sync with remote."
  task :check_revision do
    on roles(:app) do
      unless `git rev-parse HEAD` == `git rev-parse Ikasuke/production`
        puts "WARNING: HEAD is not the same as Ikasuke/production"
        puts "Run `git push` to sync changes."
        exit
      end
    end
  end

  desc "upload important files"
  task :upload do
    on roles(:app) do
      sudo :mkdir, "-p", "#{shared_path}/config"
      sudo %(chown -R #{fetch(:user)}.#{fetch(:user)} /opt/#{fetch(:application)})
      sudo :mkdir, "-p", "/etc/nginx/sites-enabled"
      sudo :mkdir, "-p", "/etc/nginx/sites-available"

      upload!("config/database.yml", "#{shared_path}/config/database.yml")
      upload!("config/credentials.yml.enc", "#{shared_path}/config/credentials.yml.enc")
      upload!("config/master.key", "#{shared_path}/config/master.key")
    end
  end

  before :starting, :upload
  before "check:linked_files", "puma:nginx_config"
  before :starting, :check_revision
end

after "deploy:published", "nginx:restart"
