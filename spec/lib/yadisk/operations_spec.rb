# frozen_string_literal: true

require "spec_helper"

describe Yadisk::Client do
  # TODO: describe > context > it
  context "#operations" do
    it "#status", :vcr do
      name = "operations/GET_status"
      VCR.use_cassette(name, allow_playback_repeats: true) do
        id = "a6e706d94c4adcd17298c1eed06729f9e9217569e6376a51c38de74d8d6367c5"
        resp = @yandex.operation.status(operation_id: id)
        CassetteHelpers::Use.new(name) do |c|
          expect(c.url).to eq("https://cloud-api.yandex.net/v1/disk/operations/#{id}")
          expect(c.code).to eq(200)
          expect(c.method).to eq("get")
        end
        expect(resp).to be_instance_of(String)
        expect(resp).to eq("in-progress")
      end
    end
  end
end
