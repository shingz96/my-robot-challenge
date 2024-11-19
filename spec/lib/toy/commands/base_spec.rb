require 'rspec'
require_relative '../../../../lib/toy/commands/base'

RSpec.describe Toy::Commands::Base do
  it 'prepended with Toy::Commands::Executability' do
    expect(described_class.ancestors.first).to eq(Toy::Commands::Executability)
  end

  describe '#execute' do
    let(:table) { double('table') }
    let(:command) { double('command') }
    let(:robot) { double('robot') }
    let(:output) { double('output') }

    it 'raises NotImplementedError' do
      expect { described_class.new(table: table, command: command, robot: robot, output: output).execute }.to raise_error(NotImplementedError)
    end
  end

  describe '.command_regex' do
    it 'raises NotImplementedError' do
      expect { described_class.command_regex }.to raise_error(NotImplementedError)
    end
  end
end
