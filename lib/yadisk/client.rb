# frozen_string_literal: true

module Yadisk
  class Client
    BASE_URL = "https://cloud-api.yandex.net/v1"
    attr_reader :api_key, :adapter

    # new client
    def initialize(api_key:, adapter: Faraday.default_adapter, stubs: nil)
      @api_key = api_key
      @adapter = adapter
      @stubs = stubs # Test stubs for requests
    end

    def disk
      DiskRest.new(self)
    end

    def operation
      OperationRest.new(self)
    end

    def trash
      TrashRest.new(self)
    end

    def public_resource
      PublicRest.new(self)
    end

    def connection
      @connection ||= Faraday.new(BASE_URL) do |conn|
        conn.request :authorization, :OAuth, api_key
        conn.request :json
        conn.request :url_encoded

        conn.response :dates
        conn.response :json, content_type: "application/json"

        # conn.response :logger, nil, {headers: true, bodies: true}

        conn.adapter adapter, @stubs
      end
    end
  end
end
