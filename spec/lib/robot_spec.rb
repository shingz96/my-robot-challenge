require 'rspec'
require_relative '../../lib/table'
require_relative '../../lib/robot'

RSpec.describe Robot do
  let(:table) { Table.new(5, 5) }
  let(:robot) { Robot.new(table) }

  describe '#initialize' do
    subject(:robot) { described_class.new(table) }

    it 'creates a Robot object with the given table' do
      expect(robot).to be_a(Robot)
      expect(robot.instance_variable_get(:@table)).to eq(table)
      expect(robot.instance_variable_get(:@placed)).to eq(false)
    end

    context 'when the table is not a Table object' do
      let(:table) { 'table' }

      it 'raises an ArgumentError' do
        expect { robot }.to raise_error(ArgumentError, 'Table must be a Table object')
      end
    end
  end

  describe '#place' do
    let(:x) { 0 }
    let(:y) { 0 }
    let(:direction) { 'NORTH' }

    subject(:place_robot) { robot.place(x, y, direction) }

    shared_examples 'does not place the robot' do
      it 'does not place the robot' do
        place_robot
        expect(robot.placed?).to eq(false)
        expect(robot.x).to be_nil
        expect(robot.y).to be_nil
        expect(robot.direction).to be_nil
      end
    end

    context 'when the given coordinates and direction are valid' do
      it 'places the robot at given coordinates and direction' do
        place_robot
        expect(robot.placed?).to eq(true)
        expect(robot.x).to eq(x)
        expect(robot.y).to eq(y)
        expect(robot.direction).to eq(direction)
      end
    end

    context 'when the given coordinates is invalid' do
      let(:x) { 5 }
      let(:y) { 5 }
      let(:direction) { 'NORTH' }

      it_behaves_like 'does not place the robot'
    end

    context 'when the given direction is invalid' do
      let(:x) { 0 }
      let(:y) { 0 }
      let(:direction) { 'INVALID' }

      it_behaves_like 'does not place the robot'
    end
  end

  describe '#move' do
    subject(:move_robot) { robot.move }

    context 'when the robot is placed in NORTH' do
      before { robot.place(0, 0, 'NORTH') }

      it 'moves one unit up' do
        move_robot
        expect(robot.x).to eq(0)
        expect(robot.y).to eq(1)
      end
    end

    context 'when the robot is placed in EAST' do
      before { robot.place(0, 0, 'EAST') }

      it 'moves one unit right' do
        move_robot
        expect(robot.x).to eq(1)
        expect(robot.y).to eq(0)
      end
    end

    context 'when the robot is placed in SOUTH' do
      before { robot.place(0, 1, 'SOUTH') }

      it 'moves one unit down' do
        move_robot
        expect(robot.x).to eq(0)
        expect(robot.y).to eq(0)
      end
    end

    context 'when the robot is placed in WEST' do
      before { robot.place(1, 0, 'WEST') }

      it 'moves one unit left' do
        move_robot
        expect(robot.x).to eq(0)
        expect(robot.y).to eq(0)
      end
    end

    context 'when the robot is not placed' do
      it 'ignores the move command' do
        move_robot
        expect(robot.x).to be_nil
        expect(robot.y).to be_nil
      end
    end

    context 'when the robot is placed and faced at the edge of the table' do
      before { robot.place(4, 4, 'NORTH') }

      it 'does not move and remain at same coordinates' do
        move_robot
        expect(robot.x).to eq(4)
        expect(robot.y).to eq(4)
      end
    end
  end

  describe '#left' do
    subject(:move_left) { robot.left }

    context 'when the robot is facing NORTH' do
      before { robot.place(0, 0, 'NORTH') }

      it 'turns left to WEST' do
        move_left
        expect(robot.direction).to eq('WEST')
      end
    end

    context 'when the robot is facing WEST' do
      before { robot.place(0, 0, 'WEST') }

      it 'turns left to SOUTH' do
        move_left
        expect(robot.direction).to eq('SOUTH')
      end
    end

    context 'when the robot is facing SOUTH' do
      before { robot.place(0, 0, 'SOUTH') }

      it 'turns left to EAST' do
        move_left
        expect(robot.direction).to eq('EAST')
      end
    end

    context 'when the robot is facing EAST' do
      before { robot.place(0, 0, 'EAST') }

      it 'turns left to NORTH' do
        move_left
        expect(robot.direction).to eq('NORTH')
      end
    end
  end

  describe '#right' do
    subject(:move_right) { robot.right }

    context 'when the robot is facing NORTH' do
      before { robot.place(0, 0, 'NORTH') }

      it 'turns right to EAST' do
        move_right
        expect(robot.direction).to eq('EAST')
      end
    end

    context 'when the robot is facing EAST' do
      before { robot.place(0, 0, 'EAST') }

      it 'turns right to SOUTH' do
        move_right
        expect(robot.direction).to eq('SOUTH')
      end
    end

    context 'when the robot is facing SOUTH' do
      before { robot.place(0, 0, 'SOUTH') }

      it 'turns right to WEST' do
        move_right
        expect(robot.direction).to eq('WEST')
      end
    end

    context 'when the robot is facing WEST' do
      before { robot.place(0, 0, 'WEST') }

      it 'turns right to NORTH' do
        move_right
        expect(robot.direction).to eq('NORTH')
      end
    end
  end

  describe '#report' do
    subject(:report) { robot.report }

    context 'when the robot is placed' do
      before { robot.place(1, 2, 'EAST') }

      it 'reports the current coordinates and direction' do
        expect(report).to eq('1,2,EAST')
      end
    end

    context 'when the robot is not placed' do
      it 'does not report anything' do
        expect(report).to be_nil
      end
    end
  end
end
