require 'rspec'
require_relative '../../../lib/toy/robot'

RSpec.describe Toy::Robot do
  let(:robot) { described_class.new }

  describe '#initialize' do
    it 'creates a Robot object with nil position' do
      expect(robot).to be_a(Toy::Robot)
      expect(robot.instance_variable_get(:@position)).to eq(nil)
    end
  end

  describe '#placed?' do
    before do
      robot.position = position
    end

    context 'when the given position is not valid' do
      let(:position) { double('something else') }

      it 'returns false' do
        expect(robot.placed?).to eq(false)
      end
    end

    context 'when the given position is valid' do
      let(:position) { Toy::Position.new(x: 5, y: 5, direction: 'NORTH') }

      it 'returns true' do
        expect(robot.placed?).to eq(true)
      end
    end
  end
end
