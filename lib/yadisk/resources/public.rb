# frozen_string_literal: true

module Yadisk
  class PublicRest < Rest
    def meta(public_url:, **params)
      PublicResource.new get_request("disk/public/resources?public_key=#{public_url}", params: params).body
    end

    def link(public_url:, **params)
      Link.new get_request("disk/public/resources/download?public_key=#{public_url}", params: params).body
    end

    def save(public_url:)
      Link.new post_request("disk/public/resources/save-to-disk?public_key=#{public_url}", body: "").body
    end
  end
end
