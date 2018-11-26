if RUBY_VERSION >= "2.4.0"
  require "warning"
  Warning.ignore([:fixnum, :bignum])
end

ENV['BUNDLE_GEMFILE'] ||= File.expand_path('../Gemfile', __dir__)

require 'bundler/setup' # Set up gems listed in the Gemfile.
require "bootsnap/setup"