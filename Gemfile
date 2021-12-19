# frozen_string_literal: true

source 'https://rubygems.org'

git_source(:github) { |repo_name| "https://github.com/#{repo_name}" }

group :development do
  gem 'byebug'
  gem 'pry'
  gem 'rubocop', require: false
  gem 'rubocop-performance', require: false
end

group :development, :test do
  gem 'rspec', '~> 3.5'
  gem 'rubocop-rspec', require: false
end
