# frozen_string_literal: true

module Yadisk
  class TrashRest < Rest
    # FIX:
    #  Yandex.Disk - error in docs or in API implemetation
    #   delete("/") - will clean all files in trash
    #   but delete("path/to/file/in/trash") - raise error DiskNotFoundError
    def delete(path:, **params)
      path = Addressable::URI.parse(path).normalize
      Object.new delete_request("disk/trash/resources?path=#{path}", params: params).body
    end

    def list(path:, **params)
      path = Addressable::URI.parse(path).normalize
      Object.new get_request("disk/trash/resources?path=#{path}", params: params).body
    end

    # FIX:
    #  Yandex.Disk - error in docs or in API implemetation
    #   restore("path/to/file/in/trash") - raise error DiskNotFoundError
    def restore(path:)
      path = Addressable::URI.parse(path).normalize
      put_request("disk/trash/resources/restore?path=#{path}", body: "")
    end
  end
end
