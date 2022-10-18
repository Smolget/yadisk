# frozen_string_literal: true

require "spec_helper"

# rubocop:disable Metrics/BlockLength
RSpec.describe "#disk" do
  describe ".info" do
    context "when params is OK" do
      subject {
        VCR.use_cassette("disk/info") do
          @yandex.disk.info
        end
      }

      it { expect(subject).to be_instance_of Yadisk::Disk }
      it { expect(subject.is_paid).to be(true).or be(false) }
    end
  end

  describe ".create_dir" do
    context "when creating a directory is OK" do
      subject {
        VCR.use_cassette("disk/create_dir") do
          @yandex.disk.create_dir path: "yadisk_created_dir"
        end
      }

      it { expect(subject).to be_an Yadisk::Link }
      it { expect(subject.href).to eq "https://cloud-api.yandex.net/v1/disk/resources?path=disk%3A%2Fyadisk_created_dir" }
    end

    context "when dir already exists" do
      subject {
        VCR.use_cassette("disk/create_dir_error_409") do
          @yandex.disk.create_dir path: "yadisk_created_dir"
        end
      }

      it { expect(subject.error).to eq "DiskPathPointsToExistentDirectoryError" }
    end
  end

  describe ".upload" do
    context "when params is OK" do
      subject {
        VCR.use_cassette("disk/upload") do
          @yandex.disk.upload(path: "yadisk_upload_here")
        end
      }

      it { expect(subject).to be_an Yadisk::ResourceUploadLink }
      it { expect(subject.operation_id).to be_an String }
      it { expect(subject.href).to match %r{/uploader9x.disk.yandex.net:443/upload-target/} }
    end
  end

  describe ".upload_from_file" do
    context "when params is OK" do
      subject {
        VCR.use_cassette("disk/upload_from_file") do
          @yandex.disk.upload_from_file(
            upload_link: "https://uploader9x.disk.yandex.net:443/upload-target/20221018T144311.680.utd.6n9ay2kos10pewsoun8tlx7gf-k7o.674502",
            src: "LICENSE"
          )
        end
      }

      it { expect(subject).to be true }
    end
  end

  describe ".upload_by_url" do
    context "when params is OK" do
      subject {
        VCR.use_cassette("disk/upload_by_url") do
          @yandex.disk.upload_by_url(path: "yadisk_test_png.png", url: "https://www.fnordware.com/superpng/pnggrad8rgb.png")
        end
      }

      it { expect(subject).to be_an Yadisk::Link }
      it { expect(subject.href).to be_an String }
    end
  end

  describe ".update_meta" do
    context "when params is OK" do
      subject {
        VCR.use_cassette("disk/update_meta") do
          @yandex.disk.update_meta(path: "yadisk_test_png.png", key: "value")
        end
      }

      it { expect(subject).to be_an Yadisk::Resource }
      it { expect(subject.custom_properties.key).to eq "value" }
    end
  end

  describe ".get_meta" do
    context "when params is OK" do
      subject {
        VCR.use_cassette("disk/get_meta") do
          @yandex.disk.get_meta(path: "yadisk_test_png.png")
        end
      }

      it { expect(subject).to be_an Yadisk::Resource }
      it { expect(subject.custom_properties.key).to eq "value" }
    end
  end

  describe ".copy" do
    context "when params is OK" do
      subject {
        VCR.use_cassette("disk/copy") do
          @yandex.disk.copy(from: "yadisk_test_png.png", to: "yadisk_test_png_copy.png")
        end
      }

      it { expect(subject).to be_an Yadisk::Link }
      it { expect(subject.href).to be_an String }
    end
  end

  describe ".download" do
    context "when params is OK" do
      subject {
        VCR.use_cassette("disk/download") do
          @yandex.disk.download(path: "yadisk_test_png_copy.png")
        end
      }

      it { expect(subject).to be_an Yadisk::Link }
      it { expect(subject.href).to be_an String }
      it { expect(subject.href).not_to be nil }
    end
  end

  describe ".list_files" do
    let(:limit) { "1" }
    context "with limit param" do
      subject {
        VCR.use_cassette("disk/list_files") do
          @yandex.disk.list_files(limit: limit)
        end
      }

      it { expect(subject).to be_an Yadisk::Collection }
      it { expect(subject.data.first).to be_an Yadisk::Resource }
    end
  end

  describe ".last_uploaded" do
    context "whith limit param" do
      subject {
        VCR.use_cassette("disk/last_uploaded") do
          @yandex.disk.last_uploaded(limit: 1)
        end
      }

      it { expect(subject).to be_an Yadisk::Collection }
      it { expect(subject.data.first).to be_an Yadisk::Resource }
    end
  end

  describe ".move" do
    context "when params is OK" do
      subject {
        VCR.use_cassette("disk/move") do
          @yandex.disk.move(from: "yadisk_test_png_copy.png", to: "yadisk.png")
        end
      }

      it { expect(subject).to be_an Yadisk::Link }
      it { expect(subject.href).to be_an String }
    end
  end

  describe ".list_public" do
    context "whit limit param" do
      subject {
        VCR.use_cassette("disk/list_public") do
          @yandex.disk.list_public(limit: 1)
        end
      }

      it { expect(subject).to be_an Yadisk::Collection }
      it { expect(subject.data.first).to be_an Yadisk::PublicResource }
    end
  end

  describe ".publish" do
    context "when params is OK" do
      subject {
        VCR.use_cassette("disk/publish") do
          @yandex.disk.publish(path: "yadisk.png")
        end
      }

      it { expect(subject).to be_an Yadisk::Link }
      it { expect(subject.href).to be_an String }
    end
  end

  describe ".unpublish" do
    context "when params is OK" do
      subject {
        VCR.use_cassette("disk/unpublish") do
          @yandex.disk.unpublish(path: "yadisk.png")
        end
      }

      it { expect(subject).to be_an Yadisk::Link }
      it { expect(subject.href).to be_an String }
    end
  end

  describe ".delete" do
    context "when params is OK" do
      subject {
        VCR.use_cassette("disk/delete") do
          @yandex.disk.delete(path: "yadisk_test_png.png")
        end
      }

      it { expect(subject).to be_an Yadisk::Object }
    end
  end
end
# rubocop:enable Metrics/BlockLength
