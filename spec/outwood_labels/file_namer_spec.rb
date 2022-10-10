# frozen_string_literal: true

RSpec.describe OutwoodLabels::FileNamer do
  let(:default_name) { "labels" }
  subject(:output) { described_class.call(default_name) }

  context "file with the same name exists" do
    before do
      expect(File).to receive(:exist?).with("#{default_name}.pdf").and_return(true)
      expect(File).to receive(:exist?).with("#{default_name}-1.pdf").and_return(false)
    end

    it { expect(output).to start_with(default_name) }
    it { expect(output).to end_with("1.pdf") }
  end

  context "file with the same name exists x2" do
    before do
      expect(File).to receive(:exist?).with("#{default_name}.pdf").and_return(true)
      expect(File).to receive(:exist?).with("#{default_name}-1.pdf").and_return(true)
      expect(File).to receive(:exist?).with("#{default_name}-2.pdf").and_return(false)
    end

    it { expect(output).to start_with(default_name) }
    it { expect(output).to end_with("2.pdf") }
  end

  context "no conflicting file exists" do
    it { expect(output).to eq("#{default_name}.pdf") }
  end
end
