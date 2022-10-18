# frozen_string_literal: true

module Yadisk
  class TrashRest < Rest
    def delete(path:, **params)
      path = Addressable::URI.parse(path).normalize
      Link.new delete_request("disk/trash/resources?path=#{path}", params: params).body
    end

    def list(path:, **params)
      path = Addressable::URI.parse(path).normalize
      TrashResource.new get_request("disk/trash/resources?path=#{path}", params: params).body
    end

    def restore(path:)
      path = Addressable::URI.parse(path).normalize
      Link.new put_request("disk/trash/resources/restore?path=#{path}", body: "").body
    end
  end
end
