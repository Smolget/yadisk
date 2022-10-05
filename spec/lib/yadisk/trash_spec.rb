# frozen_string_literal: true

require "spec_helper"

describe Yadisk::Client do
  let(:file_path) { "trash:/remote_path.txt_05572eeb69f47093eac51b40f1513d3bddff1b6c" }
  context "#trash" do
    it "#list - all", :vcr do
      name = "trash/GET_list"
      VCR.use_cassette(name, allow_playback_repeats: true) do
        resp = @yandex.trash.list(path: "/")
        CassetteHelpers::Use.new(name).url do |c|
          expect(c.url).to eq("https://cloud-api.yandex.net/v1/disk/trash/resources")
          expect(c.code).to eq(200)
          expect(c.method).to eq("get")
        end
        expect(resp).to be_instance_of(Yadisk::TrashResource)
      end
    end

    it "#list - single file", :vcr do
      name = "trash/GET_list"
      VCR.use_cassette(name, allow_playback_repeats: true) do
        resp = @yandex.trash.list(path: file_path)
        CassetteHelpers::Use.new(name).url do |c|
          expect(c.url).to eq("https://cloud-api.yandex.net/v1/disk/trash/resources")
          expect(c.code).to eq(200)
          expect(c.method).to eq("get")
        end
        expect(resp).to be_instance_of(Yadisk::TrashResource)
      end
    end

    it "#restore", :vcr do
      name = "trash/PUT_restore"
      VCR.use_cassette(name, allow_playback_repeats: true) do
        resp = @yandex.trash.restore(path: file_path)
        CassetteHelpers::Use.new(name).url do |c|
          expect(c.url).to eq("https://cloud-api.yandex.net/v1/disk/resources?path=remote_path.txt")
          expect(c.code).to eq(204)
          expect(c.method).to eq("put")
        end
        expect(resp).to be_instance_of(Yadisk::Link)
      end
    end

    it "#delete - ok", :vcr do
      name = "trash/DELETE_delete"
      VCR.use_cassette(name, allow_playback_repeats: true) do
        resp = @yandex.trash.delete(path: "trash:/remote_file.txt_f7fc32168f3b30e60994fd2e82af7d230dab5c91")
        CassetteHelpers::Use.new(name) do |c|
          expect(c.url).to eq("https://cloud-api.yandex.net/v1/disk/trash/resources")
          expect(c.code).to eq(200)
          expect(c.method).to eq("delete")
        end
        expect(resp).to be_instance_of(Yadisk::Link)
      end
    end

    # if error raised
    describe "#delete - DiskNotFoundError" do
      let(:request) { @yandex.trash.delete(path: file_path) }
      it "#delete - file not found", :vcr do
        name = "trash/DELETE_delete_error"
        VCR.use_cassette(name, allow_playback_repeats: true) do
          expect { request }.to raise_error(Yadisk::Error)
            .with_message(/DiskNotFoundError/)
        end
      end
    end
  end
end
