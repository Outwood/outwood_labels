# frozen_string_literal: true

require 'outwood_labels/cli'

RSpec.describe OutwoodLabels::CLI do
  subject(:cli) { described_class.new }

  around do |example|
    aggregate_failures(&example)
  end

  before do
    $stderr = StringIO.new
    $stdout = StringIO.new
  end

  after do
    $stderr = STDERR
    $stdout = STDOUT
  end

  describe '--list' do
    let(:args) { %w[--list] }

    it 'prints a template list' do
      result = cli.run(args)
      expect($stdout.string).to include('email-password:')
      expect(result).to eq(0)
    end
  end

  describe '--version' do
    let(:args) { %w[--version] }

    it 'prints the version' do
      result = cli.run(args)
      expect($stdout.string).to include(OutwoodLabels::VERSION)
      expect(result).to eq(0)
    end
  end
end
