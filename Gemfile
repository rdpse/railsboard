source 'https://rubygems.org'

git_source(:github) do |repo_name|
    repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
      "https://github.com/#{repo_name}.git"
end

gem 'rails',        '~> 5.0.1'
gem 'bcrypt',       '3.1.11'
gem 'puma',         '3.4.0'

gem 'sass-rails', '~> 5.0'
gem 'uglifier',     '3.0.0'
gem 'coffee-rails', '~> 4.2'
gem 'jbuilder',     '~> 2.5'

group :development, :test do
    gem 'sqlite3', '1.3.12'
    gem 'byebug',  '9.0.0', platform: :mri
end

group :development do
    gem 'web-console',           '3.1.1'
    gem 'listen',                '3.0.8'
    gem 'spring',                '1.7.2'
    gem 'spring-watcher-listen', '2.0.0'
end

group :test do
    gem 'rails-controller-testing', '0.1.1'
    gem 'minitest-reporters',       '1.1.9'
    gem 'guard',                    '2.13.0'
    gem 'guard-minitest',           '2.4.4'
end

group :production do
    gem 'pg', '0.18.4'
    gem 'unicorn'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

gem 'jquery-rails', '~> 4.3.1'
gem 'gentelella-rails'
gem 'modernizr-rails'
gem 'jquery-turbolinks'
gem 'rails-i18n'
gem 'jquery-inputmask-rails', github: 'rdpse/jquery-inputmask-rails'
gem 'remotipart', '~> 1.2' # ajax file uploads through remote forms

gem 'open_exchange_rates'
gem 'net-ping'
gem 'whenever'
gem 'ruport'
gem 'carrierwave', '~> 1.0'

# APIs
gem 'cloudflair', '~> 0.0.9'
gem 'ovh-rest'
gem 'oneprovider-api', bitbucket: 'rdpse/oneprovider-api'
gem 'stripe'
gem 'scaleway'
