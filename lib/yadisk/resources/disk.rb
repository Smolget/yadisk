# frozen_string_literal: true

module Yadisk
  class DiskRest < Rest
    def info
      Disk.new get_request("disk").body
    end

    # TOOO: more test cases
    def upload(path:)
      path = Addressable::URI.parse(path).normalize
      ResourceUploadLink.new get_request("disk/resources/upload?path=#{path}").body
    end

    def upload_from_file(upload_link:, src:)
      put_request(upload_link, body: File.open(src).read).success?
    end

    def upload_by_url(path:, url:)
      path = Addressable::URI.parse(path).normalize
      url  = Addressable::URI.parse(url).normalize
      Link.new post_request("disk/resources/upload?path=#{path}&url=#{url}", body: "").body
    end

    def delete(path:)
      path = Addressable::URI.parse(path).normalize
      delete_request("disk/resources?path=#{path}")
    end

    def get_meta(path:, **params)
      path = Addressable::URI.parse(path).normalize
      Resource.new get_request("disk/resources?path=#{path}", params: params).body
    end

    def update_meta(path:, **attributes)
      path = Addressable::URI.parse(path).normalize
      payload = {custom_properties: attributes}
      Resource.new patch_request("disk/resources?path=#{path}", body: payload).body
    end

    def create_dir(path:)
      path = Addressable::URI.parse(path).normalize
      Link.new put_request("disk/resources?path=#{path}", body: "").body
    end

    def copy(from:, to:)
      from = Addressable::URI.parse(from).normalize
      to   = Addressable::URI.parse(to).normalize
      Link.new post_request("disk/resources/copy?from=#{from}&path=#{to}", body: "").body
    end

    def download(path:, **params)
      path = Addressable::URI.parse(path).normalize
      Link.new get_request("disk/resources/download?path=#{path}", params: params).body
    end

    def list_files(**params)
      resp = get_request("disk/resources/files", params: params).body
      Collection.from_response(resp, key: "items", type: FilesResourceList)
    end

    def last_uploaded(**params)
      resp = get_request("disk/resources/last-uploaded", params: params)
      Collection.from_response(resp, key: "items", type: LastUploadedResourceList)
    end

    def move(from:, to:)
      from = Addressable::URI.parse(from).normalize
      to   = Addressable::URI.parse(to).normalize
      Link.new post_request("disk/resources/move?from=#{from}&path=#{to}", body: "").body
    end

    def list_public(**params)
      resp = get_request("disk/resources/public", params: params)
      Collection.from_response(resp, key: "items", type: PublicResourcesList)
    end

    def publish(path:)
      path = Addressable::URI.parse(path).normalize
      Link.new put_request("disk/resources/publish?path=#{path}", body: "").body
    end

    def unpublish(path:)
      path = Addressable::URI.parse(path).normalize
      Link.new put_request("disk/resources/unpublish?path=#{path}", body: "").body
    end
  end
end
