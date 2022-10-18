# frozen_string_literal: true

module CassetteHelpers
  class Use
    def initialize(name)
      path = "spec/vcr/#{name}.yml"
      @cassette = YAML.load_file(path) if File.exist?(path)
    end

    # helper method for match request URL from cassette
    def url
      @cassette["http_interactions"].first["request"]["uri"]
    end

    def method
      @cassette["http_interactions"].first["request"]["method"]
    end

    def code
      @cassette["http_interactions"].first["response"]["status"]["code"]
    end
  end
end
