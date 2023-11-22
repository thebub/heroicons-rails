# frozen_string_literal: true

source "https://rubygems.org"

# Specify your gem's dependencies in heroicons-rails.gemspec
gemspec

group :release do
  gem "nokogiri", "~> 1.15"
  gem "rubyzip", "~> 2.3"
end

group :development, :test do
  gem "minitest"
  gem "rake", "~> 13.0"
  gem "rubocop", "0.59"
  gem "rubocop-github", "0.12.0"
  gem 'rubocop-rake', require: false
  gem "rbs", "~> 1.8"
  gem "debug", "~> 1.8" 
end
