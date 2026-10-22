source 'https://rubygems.org'

require 'rbconfig'
unless File.realpath(RbConfig.ruby) == File.realpath('/opt/puppetlabs/puppet/bin/ruby')
  raise 'Use the Ruby bundled with openvox-agent: /opt/puppetlabs/puppet/bin/ruby'
end
require 'puppet/version'
unless Gem::Requirement.new('>= 8.24', '< 9.0').satisfied_by?(Gem::Version.new(Puppet.version))
  raise 'The bundled OpenVox runtime must be >= 8.24 and < 9.0'
end
ruby '>= 3.2'

aio_json = Gem::Specification.find_all_by_name('json').find(&:default_gem?)
gem 'json', "= #{aio_json.version}", :require => false

%w[base64 benchmark concurrent-ruby deep_merge fast_gettext fiddle getoptlong
  locale ostruct puppet-resource_api racc scanf semantic_puppet net-ssh
  hocon logger thor tsort].each do |name|
  installed = Gem::Specification.find_by_name(name)
  gem name, "= #{installed.version}", :require => false
end

gem 'kafo', '~> 7.8'
gem 'openvox-strings', '~> 7.2', :require => false
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
