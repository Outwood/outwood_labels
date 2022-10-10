# frozen_string_literal: true

RSpec.describe OutwoodLabels::OptionsValidator do
  subject(:validator) { described_class.new options }

  context "with no options" do
    let(:options) { {} }

    it "does not raise" do
      expect { validator.call }.not_to raise_error
    end
  end

  describe "incompatible options" do
    context "with version & list" do
      let(:options) { { version: true, list: true } }

      it "raises OptionArgumentError" do
        expect { validator.call }
          .to raise_error(OutwoodLabels::OptionArgumentError)
      end
    end
  end

  describe "style" do
    before do
      allow(OutwoodLabels).to receive(:[]).with(anything).and_return(false)
      allow(OutwoodLabels).to receive(:[]).with("account").and_return(true)
    end

    context "with a known style" do
      let(:options) { { style: "account" } }

      it "does not raise" do
        expect { validator.call }.not_to raise_error
      end
    end

    context "with an unknown style" do
      let(:options) { { style: "foo" } }

      it "raises OptionArgumentError" do
        expect { validator.call }
          .to raise_error(OutwoodLabels::OptionArgumentError)
      end
    end
  end
end
