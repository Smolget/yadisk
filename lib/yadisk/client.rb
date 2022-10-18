# frozen_string_literal: true

module Yadisk
  class Client
    BASE_URL = "https://cloud-api.yandex.net/v1"
    attr_reader :token, :adapter

    # new client
    def initialize(token:, adapter: Faraday.default_adapter, stubs: nil)
      @token = token
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
        conn.request :authorization, :OAuth, token
        conn.request :json
        conn.request :url_encoded

        conn.response :dates
        conn.response :json, content_type: "application/json"

        conn.adapter adapter, @stubs
      end
    end
  end
end
