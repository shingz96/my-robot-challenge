require 'rspec'
require_relative '../../lib/table'

RSpec.describe Table do
  describe '#initialize' do
    let(:width) { 10 }
    let(:height) { 5 }

    subject(:table) { described_class.new(width, height) }

    it 'creates a table with the specified width and height' do
      expect(table).to be_a(Table)
      expect(table.instance_variable_get(:@width)).to eq(width)
      expect(table.instance_variable_get(:@height)).to eq(height)
    end

    shared_examples 'raises an ArgumentError' do
      it 'raises an ArgumentError' do
        expect { table }.to raise_error(ArgumentError, message)
      end
    end

    context 'when the width is not a positive integer' do
      let(:width) { 0 }
      let(:message) { 'Width and height must be positive integers' }

      it_behaves_like 'raises an ArgumentError'
    end

    context 'when the height is not a positive integer' do
      let(:height) { -1 }
      let(:message) { 'Width and height must be positive integers' }

      it_behaves_like 'raises an ArgumentError'
    end
  end

  describe '#valid_position?' do
    let(:width) { 5 }
    let(:height) { 5 }
    let(:table) { described_class.new(width, height) }

    context 'when the position is within the table' do
      it 'returns true' do
        expect(table.valid_position?(0, 0)).to eq(true)
        expect(table.valid_position?(4, 4)).to eq(true)
      end
    end

    context 'when the position is outside the table' do
      it 'returns false' do
        expect(table.valid_position?(5, 0)).to eq(false)
        expect(table.valid_position?(0, 5)).to eq(false)
      end
    end
  end
end
