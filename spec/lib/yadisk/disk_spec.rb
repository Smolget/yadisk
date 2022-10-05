# frozen_string_literal: true

require "spec_helper"

# e2e vars
# test_file_path = "spec/test_data/test_file.txt"
test_file_name = "remote_file.txt"
test_upload_link = ""

# rubocop:disable Metrics/BlockLength
describe Yadisk::Client do
  # TODO: refactor by separating test cases - HOW TO DO THIS ?
  # TODO: describe > context > it
  context "#disk" do
    it "#info", :vcr do
      name = "disk/GET_info"
      VCR.use_cassette(name, allow_playback_repeats: true) do
        resp = @yandex.disk.info
        CassetteHelpers::Use.new(name) do |c|
          expect(c.url).to eq("https://cloud-api.yandex.net/v1/disk")
          expect(c.code).to eq(200)
          expect(c.method).to eq("get")
        end
        expect(resp).to be_instance_of(Yadisk::Disk)
      end
    end

    it "#upload", :vcr do
      name = "disk/GET_upload"
      VCR.use_cassette(name, allow_playback_repeats: true) do
        resp = @yandex.disk.upload(path: test_file_name)
        test_upload_link = resp.href
        CassetteHelpers::Use.new(name) do |c|
          expect(c.url).to eq("https://cloud-api.yandex.net/v1/disk/resources/upload?path=remote_file.txt")
          expect(c.code).to eq(200)
          expect(c.method).to eq("get")
        end
        expect(resp).to be_instance_of(Yadisk::ResourceUploadLink)
      end
    end

    # it "#upload_from_file", :vcr do
    #   name = "disk/PUT_upload_from_file"
    #   VCR.use_cassette(name, allow_playback_repeats: true) do
    #     @yandex.disk.upload_from_file(upload_link: test_upload_link, src: test_file_path)
    #     CassetteHelpers::Use.new(name) do |c|
    #       expect(c.url).to eq(upload_link)
    #       expect(c.code).to eq(201)
    #       expect(c.method).to eq("put")
    #     end
    #   end
    # end

    it "#upload_by_url", :vcr do
      name = "disk/POST_upload_by_url"
      VCR.use_cassette(name, allow_playback_repeats: true) do
        path = "uploaded_by_url.png"
        link = "https://www.example.com/image.png"
        @yandex.disk.upload_by_url(path: path, url: link)

        CassetteHelpers::Use.new(name) do |c|
          expect(c.url).to eq("https://cloud-api.yandex.net/v1/disk/resources/upload?path=#{path}&url=#{link}")
          expect(c.code).to eq(202)
          expect(c.method).to eq("post")
        end
      end
    end

    it "#get_meta", :vcr do
      name = "disk/GET_get_meta"
      VCR.use_cassette(name, allow_playback_repeats: true) do
        resp = @yandex.disk.get_meta(path: "remote_file.txt")
        CassetteHelpers::Use.new(name) do |c|
          expect(c.url).to eq("https://cloud-api.yandex.net/v1/disk/resources?path=/remote_file.txt")
          expect(c.code).to eq(200)
          expect(c.method).to eq("get")
        end
        expect(resp).to be_instance_of(Yadisk::Resource)
      end
    end

    it "#update_meta", :vcr do
      name = "disk/PATCH_update_meta"
      VCR.use_cassette(name, allow_playback_repeats: true) do
        resp = @yandex.disk.update_meta(path: "remote_file.txt", key_one: "value_1", key_two: "value_2")
        CassetteHelpers::Use.new(name) do |c|
          expect(c.url).to eq("https://cloud-api.yandex.net/v1/disk/resources")
          expect(c.code).to eq(200)
          expect(c.method).to eq("patch")
        end
        expect(resp).to be_instance_of(Yadisk::Resource)
      end
    end

    it "#create_dir", :vcr do
      name = "disk/PUT_create_dir"
      VCR.use_cassette(name, allow_playback_repeats: true) do
        resp = @yandex.disk.create_dir(path: "test_dir")
        CassetteHelpers::Use.new(name) do |c|
          expect(c.url).to eq("https://cloud-api.yandex.net/v1/disk/resources")
          expect(c.code).to eq(200)
          expect(c.method).to eq("get")
        end
        expect(resp).to be_instance_of(Yadisk::Link)
      end
    end

    it "#copy", :vcr do
      name = "disk/POST_copy"
      VCR.use_cassette(name, allow_playback_repeats: true) do
        resp = @yandex.disk.copy(from: "remote_file.txt", to: "remote_file_copy.txt")
        CassetteHelpers::Use.new(name) do |c|
          expect(c.url).to eq("https://cloud-api.yandex.net/v1/disk/resources/copy")
          expect(c.code).to eq(200)
          expect(c.method).to eq("post")
        end
        expect(resp).to be_instance_of(Yadisk::Link)
      end
    end

    it "#download", :vcr do
      name = "disk/GET_download"
      VCR.use_cassette(name, allow_playback_repeats: true) do
        resp = @yandex.disk.download(path: "remote_file.txt")
        CassetteHelpers::Use.new(name) do |c|
          expect(c.url).to eq("https://cloud-api.yandex.net/v1/disk/resources")
          expect(c.code).to eq(200)
          expect(c.method).to eq("get")
        end
        expect(resp).to be_instance_of(Yadisk::Link)
      end
    end

    # it "#list_files", :vcr do
    #   name = "disk/GET_list_files"
    #   VCR.use_cassette(name, allow_playback_repeats: true) do
    #     @yandex.disk.list_files
    #     CassetteHelpers::Use.new(name) do |c|
    #       expect(c.url).to eq("https://cloud-api.yandex.net/v1/disk/resources")
    #       expect(c.code).to eq(200)
    #       expect(c.method).to eq("get")
    #     end
    #     expect(resp).to be_instance_of(Yadisk::Disk)
    #   end
    # end

    # TODO: filter sensitive data
    # it "#last_uploaded", :vcr do
    #   name = "disk/GET_last_uploaded"
    #   VCR.use_cassette(name, allow_playback_repeats: true) do
    #     resp = @yandex.disk.last_uploaded
    #     CassetteHelpers::Use.new(name) do |c|
    #       expect(c.url).to eq("https://cloud-api.yandex.net/v1/disk/resources")
    #       expect(c.code).to eq(200)
    #       expect(c.method).to eq("get")
    #     end
    #     expect(resp).to be_instance_of(Yadisk::Collection)
    #   end
    # end

    it "#move", :vcr do
      name = "disk/POST_move"
      VCR.use_cassette(name, allow_playback_repeats: true) do
        resp = @yandex.disk.move(from: "remote_file_copy.txt", to: "remote_file_new_name.txt")
        CassetteHelpers::Use.new(name) do |c|
          expect(c.url).to eq("https://cloud-api.yandex.net/v1/disk/resources/move")
          expect(c.code).to eq(200)
          expect(c.method).to eq("post")
        end
        expect(resp).to be_instance_of(Yadisk::Link)
      end
    end

    it "#list_public", :vcr do
      name = "disk/GET_list_public"
      VCR.use_cassette(name, allow_playback_repeats: true) do
        resp = @yandex.disk.list_public
        CassetteHelpers::Use.new(name) do |c|
          expect(c.url).to eq("https://cloud-api.yandex.net/v1/disk/resources/public")
          expect(c.code).to eq(200)
          expect(c.meth).to eq("get")
        end
        expect(resp).to be_instance_of(Yadisk::Collection)
      end
    end

    it "#publish", :vcr do
      name = "disk/PUT_publish"
      VCR.use_cassette(name, allow_playback_repeats: true) do
        resp = @yandex.disk.publish(path: test_file_name)
        CassetteHelpers::Use.new(name) do |c|
          expect(c.url).to eq("https://cloud-api.yandex.net/v1/disk/resources/publish")
          expect(c.code).to eq(200)
          expect(c.method).to eq("put")
        end
        expect(resp).to be_instance_of(Yadisk::Link)
      end
    end

    it "#unpublish", :vcr do
      name = "disk/PUT_unpublish"
      VCR.use_cassette(name, allow_playback_repeats: true) do
        resp = @yandex.disk.unpublish(path: test_file_name)
        CassetteHelpers::Use.new(name).url do |c|
          expect(c.url).to eq("https://cloud-api.yandex.net/v1/disk/resources/unpublish")
          expect(c.code).to eq(200)
          expect(c.method).to eq("put")
        end
        expect(resp).to be_instance_of(Yadisk::Link)
      end
    end

    it "#delete", :vcr do
      name = "disk/DELETE_delete"
      VCR.use_cassette(name, allow_playback_repeats: true) do
        @yandex.disk.delete(path: test_file_name)
        CassetteHelpers::Use.new(name).url do |c|
          expect(c.url).to eq("https://cloud-api.yandex.net/v1/disk/resources?path=remote_file.txt")
          expect(c.code).to eq(204)
          expect(c.method).to eq("delete")
        end
      end
    end
  end
end
# rubocop:enable Metrics/BlockLength
