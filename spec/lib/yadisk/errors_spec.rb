# frozen_string_literal: true

require "spec_helper"

describe Yadisk::Client do
  context "client with bad credentials.", :vcr do
    let(:client) { Yadisk::Client.new(token: "very bad token").disk.info }
    let(:name) { "disk/ERROR_info" }
    it "UnauthorizedError" do
      VCR.use_cassette(name, allow_playback_repeats: true) do
        expect { client }.to raise_error(Yadisk::Error)
          .with_message(/did not supply valid authentication/)
      end
    end
  end
end
