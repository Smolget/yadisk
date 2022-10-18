# frozen_string_literal: true

require "spec_helper"

RSpec.describe "#public" do
  let(:public_url) { "https://disk.yandex.ru/d/XzWAb9JaK605ig" }

  describe ".meta" do
    context "when params is OK" do
      subject {
        VCR.use_cassette("public/meta") do
          @yandex.public_resource.meta public_url: public_url
        end
      }

      it { expect(subject).to be_an Yadisk::PublicResource }
    end
  end

  describe ".link" do
    context "when params is OK" do
      subject {
        VCR.use_cassette("public/link") do
          @yandex.public_resource.link public_url: public_url
        end
      }

      it { expect(subject).to be_an Yadisk::Link }
    end
  end

  describe ".save" do
    context "when params is OK" do
      subject {
        VCR.use_cassette("public/save") do
          @yandex.public_resource.save public_url: public_url
        end
      }

      it { expect(subject).to be_an Yadisk::Link }
    end
  end
end
