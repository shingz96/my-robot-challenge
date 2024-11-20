require 'rspec'
require_relative '../../../../lib/toy/commands/executable'

RSpec.describe Toy::Commands::Executable do
  let(:dummy_class) do
    Class.new do
      prepend Toy::Commands::Executable

      def initialize(command)
        @command = command
      end

      def execute
        'executed'
      end

      def self.command_regex
        /^dummy$/
      end
    end
  end

  describe '#execute' do
    subject(:execute) { dummy_class.new(command).execute }

    context 'when the command regex is match' do
      let(:command) { 'dummy' }

      it 'executes the command' do
        expect(execute).to eq('executed')
      end
    end

    context 'when the command regex is not match' do
      let(:command) { 'not_dummy' }

      it 'does not execute the command' do
        expect(execute).to eq(nil)
      end
    end
  end

  describe '#match_data' do
    subject(:match_data) { dummy_class.new('dummy').match_data }

    it 'returns the match data' do
      expect(match_data).to be_a(MatchData)
      expect(match_data[0]).to eq('dummy')
    end
  end
end
