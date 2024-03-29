# frozen_string_literal: true

require File.expand_path("./vcr_setup", __dir__)

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), "..", "lib"))
$LOAD_PATH.unshift(File.dirname(__FILE__))

require "simplecov"
require "simplecov-lcov"

require_relative "../lib/yadisk"

SimpleCov::Formatter::LcovFormatter.config.report_with_single_file = true
SimpleCov.formatter = SimpleCov::Formatter::LcovFormatter

SimpleCov.start do
  add_filter "spec/"
  add_group "Lib", "lib"
  minimum_coverage 80.0
end

ACCESS_TOKEN = ENV["YANDEX_DISK_ACCESS_TOKEN"] || "your_access_token"

RSpec.configure do |config|
  config.before(:each) do
    @yandex = Yadisk::Client.new(token: ACCESS_TOKEN)
  end

  config.expect_with :rspec do |c|
    c.syntax = %i[expect]
  end

  config.mock_with :rspec do |c|
    c.syntax = %i[expect]
  end
end
