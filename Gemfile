# frozen_string_literal: true

source 'https://rubygems.org'

git_source(:github) { |repo_name| "https://github.com/#{repo_name}" }

group :development do
  gem 'rubocop', require: false
  gem 'rubocop-performance', require: false
end

group :development, :test do
  gem 'byebug'
  gem 'rspec', '~> 3.5'
  gem 'rubocop-rake'
  gem 'rubocop-rspec', require: false
end
