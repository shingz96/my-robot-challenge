require 'rspec'
require_relative '../../../lib/toy/position'

RSpec.describe Toy::Position do
  let(:position) { described_class.new(x: x, y: y, direction: direction) }
  let(:x) { 0 }
  let(:y) { 0 }
  let(:direction) { 'NORTH' }

  describe '#initialize' do
    it 'creates a Position object with x, y, and direction' do
      expect(position).to be_a(Toy::Position)
      expect(position.x).to eq(x)
      expect(position.y).to eq(y)
      expect(position.direction).to eq(direction)
    end

    context 'when x is not an Integer' do
      let(:x) { 'x' }

      it 'raises an ArgumentError' do
        expect { position }.to raise_error(ArgumentError, 'Invalid position')
      end
    end

    context 'when y is not an Integer' do
      let(:y) { 'y' }

      it 'raises an ArgumentError' do
        expect { position }.to raise_error(ArgumentError, 'Invalid position')
      end
    end

    context 'when direction is not valid' do
      let(:direction) { 'INVALID' }

      it 'raises an ArgumentError' do
        expect { position }.to raise_error(ArgumentError, 'Invalid direction')
      end
    end
  end

  describe '#move' do
    subject(:move) { position.move }

    context 'when the direction is NORTH' do
      let(:direction) { 'NORTH' }

      it 'returns position with one unit up' do
        expect(move).to eq(Toy::Position.new(x: x, y: y + 1, direction: direction))
      end
    end

    context 'when the direction is EAST' do
      let(:direction) { 'EAST' }

      it 'returns the position with one unit right' do
        expect(move).to eq(Toy::Position.new(x: x + 1, y: y, direction: direction))
      end
    end

    context 'when the direction is SOUTH' do
      let(:direction) { 'SOUTH' }

      it 'returns the position with one unit down' do
        expect(move).to eq(Toy::Position.new(x: x, y: y - 1, direction: direction))
      end
    end

    context 'when the direction is WEST' do
      let(:direction) { 'WEST' }

      it 'returns the position with one unit left' do
        expect(move).to eq(Toy::Position.new(x: x - 1, y: y, direction: direction))
      end
    end
  end

  describe '#left' do
    subject(:left) { position.left }

    context 'when the direction is NORTH' do
      let(:direction) { 'NORTH' }

      it 'returns the position with direction WEST' do
        expect(left).to eq(Toy::Position.new(x: x, y: y, direction: 'WEST'))
      end
    end

    context 'when the direction is EAST' do
      let(:direction) { 'EAST' }

      it 'returns the position with direction NORTH' do
        expect(left).to eq(Toy::Position.new(x: x, y: y, direction: 'NORTH'))
      end
    end

    context 'when the direction is SOUTH' do
      let(:direction) { 'SOUTH' }

      it 'returns the position with direction EAST' do
        expect(left).to eq(Toy::Position.new(x: x, y: y, direction: 'EAST'))
      end
    end

    context 'when the direction is WEST' do
      let(:direction) { 'WEST' }

      it 'returns the position with direction SOUTH' do
        expect(left).to eq(Toy::Position.new(x: x, y: y, direction: 'SOUTH'))
      end
    end
  end

  describe '#right' do
    subject(:right) { position.right }

    context 'when the direction is NORTH' do
      let(:direction) { 'NORTH' }

      it 'returns the position with direction EAST' do
        expect(right).to eq(Toy::Position.new(x: x, y: y, direction: 'EAST'))
      end
    end

    context 'when the direction is EAST' do
      let(:direction) { 'EAST' }

      it 'returns the position with direction SOUTH' do
        expect(right).to eq(Toy::Position.new(x: x, y: y, direction: 'SOUTH'))
      end
    end

    context 'when the direction is SOUTH' do
      let(:direction) { 'SOUTH' }

      it 'returns the position with direction WEST' do
        expect(right).to eq(Toy::Position.new(x: x, y: y, direction: 'WEST'))
      end
    end
  end
end
