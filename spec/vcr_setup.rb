# frozen_string_literal: true

require "vcr"
require "webmock"
require "webmock/rspec"
require "addressable/uri"

VCR.configure do |config|
  config.uri_parser = Addressable::URI
  config.cassette_library_dir = "spec/vcr"
  config.hook_into :webmock
  config.configure_rspec_metadata!

  config.filter_sensitive_data("[**********]") {|data|
    data.dig(:request, :headers, "Authorization", 0)
  }

  config.filter_sensitive_data("omitted") {|data|
    data.dig(:response, :headers, "Yandex-Cloud-Request-Id", 0)
  }

  config.before_record do |r|
    r.response.body.force_encoding(Encoding::UTF_8)
  end

  config.default_cassette_options = {
    record: :new_episodes,
    re_record_interval: 259_200,
    match_requests_on: %i[method uri body]
  }
end
