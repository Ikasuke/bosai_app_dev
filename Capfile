
#-----------------------------------------------------------------------
# 設定ファイルの書き方については、Capistranoの公式ドキュメントを参照してください。
# http://capistranorb.com/documentation/getting-started/configuration/
#  https://github.com/ror5book/RailsSampleApp/blob/master/Capfile
#  から参照
#-----------------------------------------------------------------------

# Include tasks from other gems included in your Gemfile
#
# For documentation on these, see for example:
#
#   https://github.com/capistrano/rvm
#   https://github.com/capistrano/rbenv
#   https://github.com/capistrano/chruby
#   https://github.com/capistrano/bundler
#   https://github.com/capistrano/rails
#   https://github.com/capistrano/passenger
#
# require "capistrano/rvm"
# require "capistrano/chruby"
# require "capistrano/rails/assets"
# require "capistrano/passenger"
require "capistrano/setup"
require "capistrano/deploy"
require "capistrano/rails"
require "capistrano/rbenv"

require "capistrano/bundler"
require "capistrano/rails/migrations"
require "capistrano/rails/assets"
require "capistrano/scm/git"
require "capistrano/puma"
require "capistrano/nginx"
require "capistrano/sidekiq"

# Load the SCM plugin appropriate to your project:
#
# require "capistrano/scm/hg"
# install_plugin Capistrano::SCM::Hg
# or
# require "capistrano/scm/svn"
# install_plugin Capistrano::SCM::Svn
# or
install_plugin Capistrano::SCM::Git
install_plugin Capistrano::Puma
install_plugin Capistrano::Puma::Nginx

# Load custom tasks from `lib/capistrano/tasks` if you have any defined
Dir.glob("lib/capistrano/tasks/*.rake").each { |r| import r }
