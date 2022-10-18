# frozen_string_literal: true

require "spec_helper"

# rubocop:disable Metrics/BlockLength
RSpec.describe "#trash" do
  describe ".delete" do
    context "when params is OK" do
      subject {
        VCR.use_cassette("trash/delete") do
          @yandex.trash.delete path: "yadisk_created_dir_12b63824b98bc5eb70d25c703cfc3224a46e6896"
        end
      }

      it { expect(subject).to be_an Yadisk::Link }
    end
  end

  describe ".list" do
    context "when params is OK" do
      subject {
        VCR.use_cassette("trash/list") do
          @yandex.trash.list path: ""
        end
      }

      it { expect(subject).to be_an Yadisk::TrashResource }
    end
  end

  describe ".restore" do
    context "when params is OK" do
      subject {
        VCR.use_cassette("trash/restore") do
          @yandex.trash.restore path: "yadisk_created_dir_857c8d0feba033c7559ade2c7c07fef3ae41c046"
        end
      }

      it { expect(subject).to be_an Yadisk::Link }
    end
  end
end
# rubocop:enable Metrics/BlockLength
