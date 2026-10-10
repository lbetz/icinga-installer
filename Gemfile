source 'https://rubygems.org'

gem 'kafo', '~> 6.0'
gem 'librarian-puppet'
gem 'openvox', ENV.fetch('OPENVOX_VERSION', '~> 8.0'), '>= 8.0', '< 9.0', :require => false

gem 'puppet-strings'
gem 'rake'

group :test do
  gem 'rspec'
  gem 'rubocop', '~> 0.80.0'
end

group :development do
  # Dependencies for rake pin_modules
  gem 'puppet_forge'
  gem 'semverse'
end
