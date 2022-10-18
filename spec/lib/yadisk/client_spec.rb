# frozen_string_literal: true

require "spec_helper"

describe Yadisk::Client do
  context "client with token: test" do
    it "returns correct instance of Yadisk::Client" do
      expect(@yandex).to be_kind_of(Yadisk::Client)
    end
  end

  context "client without token" do
    let(:client) { Yadisk::Client.new }
    it "returns nil" do
      expect { client }.to raise_error(ArgumentError)
        .with_message("missing keyword: token")
    end
  end
end
