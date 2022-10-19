# frozen_string_literal: true

require "spec_helper"

describe Yadisk::Client do
  context "client with token: test" do
    it "returns correct instance of Yadisk::Client" do
      expect(@yandex).to be_kind_of(Yadisk::Client)
    end
  end
end
