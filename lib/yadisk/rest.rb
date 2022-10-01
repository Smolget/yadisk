# frozen_string_literal: true

module Yadisk
  class Rest
    attr_reader :client

    def initialize(client)
      @client = client
    end

    private

    def get_request(url, params: {}, headers: {})
      handle_response client.connection.get(url, params, headers)
    end

    def post_request(url, body:, headers: {})
      handle_response client.connection.post(url, body, headers)
    end

    def patch_request(url, body:, headers: {})
      handle_response client.connection.patch(url, body, headers)
    end

    def put_request(url, body:, headers: {})
      handle_response client.connection.put(url, body, headers)
    end

    def delete_request(url, params: {}, headers: {})
      handle_response client.connection.delete(url, params, headers)
    end

    # rubocop:disable Metrics/CyclomaticComplexity
    # rubocop:disable Metrics/AbcSize
    def handle_response(response)
      case response.status
      when 400
        raise Error, "Your request was malformed. #{response.body['error']}"
      when 401
        raise Error, "You did not supply valid authentication credentials. #{response.body['error']}"
      when 403
        raise Error, "You are not allowed to perform that action. #{response.body['error']}"
      when 404
        raise Error, "No results were found for your request. #{response.body['error']}"
      when 429
        raise Error, "Your request exceeded the API rate limit. #{response.body['error']}"
      when 500
        raise Error, "We were unable to perform the request due to server-side problems. #{response.body['error']}"
      when 503
        raise Error, "You have been rate limited for sending more  requests per second. #{response.body['error']}"
      end

      response
    end
    # rubocop:enable Metrics/AbcSize
    # rubocop:enable Metrics/CyclomaticComplexity
  end
end
