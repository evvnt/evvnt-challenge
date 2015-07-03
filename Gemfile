source 'https://rubygems.org'
ruby '2.1.5'

gem 'bundler', '>= 1.8.4'
gem 'rails', '3.2.19'
gem 'pg'
gem 'httparty'
gem 'figaro'
gem 'foreman'
gem 'sidekiq'
gem 'sinatra', require: nil
gem 'will_paginate', '~> 3.0.6'
gem 'active_model_serializers'

group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'uglifier', '>= 1.0.3'
end

gem 'jquery-rails'
gem 'rspec-rails'

source 'https://rails-assets.org' do
  gem 'rails-assets-bootstrap'
  gem 'rails-assets-angular'
  gem 'rails-assets-angular-resource'
  gem 'rails-assets-angular-ui-router'
end

group :production do
  gem 'rails_12factor'
  gem 'redis'
end
