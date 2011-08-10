source 'http://rubygems.org'

require 'rbconfig'

gem 'rails', '3.1.0.rc4'
gem 'pg'

gem 'sass-rails', "~> 3.1.0.rc"
gem 'coffee-script'
gem 'uglifier'
gem 'jquery-rails'

gem 'sorcery'
gem 'cancan'
gem 'foreigner'
gem 'rmagick'
gem 'carrierwave'
gem 'state_machine'
gem 'formtastic'

gem 'i18n'

gem 'capistrano'
gem 'therubyracer'
gem 'hoptoad_notifier'

group :development, :test do
  gem 'active_reload'

  gem 'fabrication'
  gem 'capybara'
  gem 'database_cleaner'
  gem 'shoulda-matchers'
  gem 'rspec-rails'
  gem 'launchy'

  # Guard specific
  gem 'growl'
  gem 'guard'
  gem 'guard-rspec'
  gem 'guard-rails'
  gem 'guard-livereload'
  # TODO: gem 'guard-rails-assets'

  if Config::CONFIG['target_os'] =~ /darwin/i
    gem 'rb-fsevent'
    gem 'guard-pow'
  end

  if Config::CONFIG['target_os'] =~ /linux/i
    gem 'rb-inotify'
    gem 'libnotify'
  end
end

