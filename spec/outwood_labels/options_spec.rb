# frozen_string_literal: true

RSpec.describe OutwoodLabels::Options do
  before do
    allow(OutwoodLabels::OptionsValidator).to receive(:call).and_return(true)
  end
  subject(:options) { described_class.new args }

  context "with no options" do
    let(:args) { [] }

    it "does not raise" do
      expect { options.call }.not_to raise_error
    end
  end

  describe "--version" do
    let(:args) { ["--version"] }

    it "returns version true" do
      expect(options.call).to include(version: true)
    end
  end

  describe "--list" do
    let(:args) { ["--list"] }

    it "returns list true" do
      expect(options.call).to include(list: true)
    end
  end

  describe "--out" do
    context "with no argument" do
      let(:args) { ["--out"] }

      it "raises" do
        expect { options.call }.to raise_error(OptionParser::MissingArgument)
      end
    end

    context "with an argument" do
      let(:args) { ["--out", "foo.txt"] }

      it "returns value" do
        expect(options.call).to include(output_path: "foo.txt")
      end
    end
  end

  describe "--break" do
    context "with no argument" do
      let(:args) { ["--break"] }

      it "raises" do
        expect { options.call }.to raise_error(OptionParser::MissingArgument)
      end
    end

    context "with an argument" do
      let(:args) { ["--break", "foo"] }

      it "returns value" do
        expect(options.call).to include(break_on: "foo")
      end
    end
  end

  describe "--style" do
    context "with no argument" do
      let(:args) { ["--style"] }

      it "raises" do
        expect { options.call }.to raise_error(OptionParser::MissingArgument)
      end
    end

    context "with an argument" do
      let(:args) { ["--style", "style"] }

      it "returns value" do
        expect(options.call).to include(style: "style")
      end
    end
  end
end
