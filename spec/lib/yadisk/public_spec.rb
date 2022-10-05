# frozen_string_literal: true

require "spec_helper"

# TODO: make specs code cleaner
# TODO: describe > context > it
describe Yadisk::Client do
  context "#public" do
    it "#meta", :vcr do
      name = "public/GET_meta"
      VCR.use_cassette(name, allow_playback_repeats: true) do
        url = "https://disk.yandex.ru/d/Th-o2SkdjoALxA"
        resp = @yandex.public_resource.meta(public_url: url)
        CassetteHelpers::Use.new(name) do |c|
          expect(c.url).to eq("https://cloud-api.yandex.net/v1/disk/operations/#{id}")
          expect(c.code).to eq(200)
          expect(c.method).to eq("get")
        end
        expect(resp).to be_instance_of(Yadisk::PublicResource)
      end
    end

    it "#link", :vcr do
      name = "public/GET_link"
      VCR.use_cassette(name, allow_playback_repeats: true) do
        url = "https://disk.yandex.ru/d/Th-o2SkdjoALxA"
        resp = @yandex.public_resource.link(public_url: url)
        CassetteHelpers::Use.new(name) do |c|
          expect(c.url).to eq("https://cloud-api.yandex.net/v1/disk/operations/#{id}")
          expect(c.code).to eq(200)
          expect(c.method).to eq("get")
        end
        expect(resp).to be_instance_of(Yadisk::Link)
      end
    end

    it "#save", :vcr do
      name = "public/POST_save"
      VCR.use_cassette(name, allow_playback_repeats: true) do
        url = "https://disk.yandex.ru/d/Th-o2SkdjoALxA"
        resp = @yandex.public_resource.save(public_url: url)
        CassetteHelpers::Use.new(name) do |c|
          expect(c.url).to eq("https://cloud-api.yandex.net/v1/disk/operations/#{id}")
          expect(c.code).to eq(200)
          expect(c.method).to eq("post")
        end
        expect(resp).to be_instance_of(Yadisk::Link)
      end
    end
  end
end
