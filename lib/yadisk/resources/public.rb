# frozen_string_literal: true

module Yadisk
  class PublicRest < Rest
    def get_meta(public_url:, **params)
      Object.new get_request("disk/public/resources?public_key=#{public_url}", params: params).body
    end

    def get_link(public_url:, **params)
      Object.new get_request("disk/public/resources/download?public_key=#{public_url}", params: params).body
    end

    def save(public_url:)
      Object.new post_request("disk/public/resources/save-to-disk?public_key=#{public_url}", body: "").body
    end
  end
end
