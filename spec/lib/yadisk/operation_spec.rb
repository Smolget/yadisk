# frozen_string_literal: true

require "spec_helper"

RSpec.describe "#operation" do
  describe ".status" do
    context "when params is OK" do
      subject {
        VCR.use_cassette("operation/status") do
          @yandex.operation.status operation_id: "78ccc91b3a034a941a72dde1ae92fbf26d0facf9bad941eee9b432f4abdfdd1e"
        end
      }

      it { expect(subject).to be_an String }
      it { expect(subject).to eq "success" }
    end
  end
end
