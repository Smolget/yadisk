# frozen_string_literal: true

module Yadisk
  class Collection
    attr_reader :data, :items, :total, :limit, :offset

    def self.from_response(response, key:, type:)
      body = response.body
      new(
        data: body[key].map {|attrs| type.new(attrs) },
        items: body["items"],
        total: body["total"]
        # limit:  body.dig("limit"),
        # offset: body.dig("offset")
      )
    end

    def initialize(data:, total:, items:)
      @data   = data
      @items  = items
      @total  = total
      # @limit  = limit.empty? ? nil : limit
      # @offset = offset.empty? ? nil : offset
    end
  end
end
