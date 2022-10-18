# frozen_string_literal: true

require "./spec/support/cassette_helpers" # VCR helpers
require File.expand_path("./vcr_setup", __dir__)

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), "..", "lib"))
$LOAD_PATH.unshift(File.dirname(__FILE__))

require_relative "../lib/yadisk"

ACCESS_TOKEN = ENV["YANDEX_DISK_ACCESS_TOKEN"] || "your_access_token"

RSpec.configure do |config|
  config.include CassetteHelpers
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
