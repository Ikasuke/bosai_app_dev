# frozen_string_literal: true

source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "2.4.1"

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem "rails", "~> 5.2.1"
# Use mysql as the database for Active Record
gem "mysql2", ">= 0.4.4", "< 0.6.0"
# Use Puma as the app server
gem "puma", "~> 3.11"
# Use SCSS for stylesheets
gem "sass-rails", "~> 5.0"
# Use Uglifier as compressor for JavaScript assets
gem "uglifier", ">= 1.3.0"
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'mini_racer', platforms: :ruby

# Use CoffeeScript for .coffee assets and views
gem "coffee-rails", "~> 4.2"

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem "jbuilder", "~> 2.5"
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use ActiveStorage variant
# gem 'mini_magick', '~> 4.8'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# Reduces boot times through caching; required in config/boot.rb
gem "bootsnap", ">= 1.1.0", require: false

# bootstrap4を使う
gem "bootstrap", "> 4.0.0.beta2.1"
gem "popper_js", "> 1.12.3"
gem "tether-rails"

# calendar表示 bootstrap4用
gem "bootstrap4-datetime-picker-rails"
gem "momentjs-rails", ">= 2.9.0"

#icons
gem "font-awesome-rails"

# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem "turbolinks", "~> 5"

# jquery
gem "jquery-rails"
gem "jquery-turbolinks"
gem "jquery-ui-rails"

# ログイン認証,
gem "devise"
# gem 'redis'
# gem 'redis-rails'

# 画像アップローダ
gem "paperclip", "~> 5.0.0"

# ユーザー管理
gem "activeadmin"
gem "rails-i18n"
#aws
gem "aws-sdk", "~> 2.3"

#非同期処理
gem "sidekiq"
gem "sinatra"

#session 管理
gem "redis-rails"

#バッチの定期処理 cron
gem "whenever", require: false

# pageing
gem "kaminari"
gem "kaminari-bootstrap"

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem "byebug", platforms: %i[mri mingw x64_mingw]

  # ダミーデータ
  gem "faker"
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem "listen", ">= 3.0.5", "< 3.2"
  gem "web-console", ">= 3.3.0"
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem "spring"
  gem "spring-watcher-listen", "~> 2.0.0"

  # debug用
  gem "better_errors"
  gem "binding_of_caller"
  gem "pry-byebug"
  gem "pry-rails"

  # コードチェック
  gem "overcommit"
  gem "rubocop"

  # ストラクチャ情報
  gem "annotate"

  #capistrano
  gem "capistrano"
  gem "capistrano-rbenv"
  gem "capistrano-bundler"
  gem "capistrano-rails"
  gem "capistrano3-puma"
  gem "capistrano-nginx"
  gem "capistrano-sidekiq"
  gem "capistrano-nodenv", "~> 1.0", ">= 1.0.1"
  # メールをブラウザで確認　
  #gem "letter_opener"
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: %i[mingw mswin x64_mingw jruby]
