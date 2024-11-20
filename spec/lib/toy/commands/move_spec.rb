require 'rspec'
require_relative '../../../../lib/toy/commands/move'
require_relative '../../../../lib/toy/robot'
require_relative '../../../../lib/toy/table'
require_relative '../../../../lib/toy/position'

RSpec.describe Toy::Commands::Move do
  describe '#execute' do
    let(:table) { Toy::Table.new(5, 5) }
    let(:robot) { Toy::Robot.new }
    let(:command) { 'MOVE' }
    let(:output) { double('output') }

    subject(:move_command) { described_class.new(robot: robot, table: table, command: command, output: output).execute }

    context 'when the robot is not placed on the table' do
      it 'does not move the robot' do
        move_command

        expect(robot.position).to eq(nil)
      end
    end

    context 'when the robot is placed on the table' do
      let(:expected_position) { initial_position.move }

      before do
        robot.position = initial_position
      end

      context 'when the robot still have room to move on the table' do
        let(:initial_position) { Toy::Position.new(x: 0, y: 0, direction: 'NORTH') }

        it 'move the robot on the table' do
          move_command

          expect(robot.position.x).to eq(expected_position.x)
          expect(robot.position.y).to eq(expected_position.y)
          expect(robot.position.direction).to eq(expected_position.direction)
        end
      end

      context "when the robot's position is at the edge of table" do
        let(:initial_position) { Toy::Position.new(x: 5, y: 5, direction: 'NORTH') }

        it 'does not move the robot and remain at same position' do
          move_command

          expect(robot.position.x).to eq(initial_position.x)
          expect(robot.position.y).to eq(initial_position.y)
          expect(robot.position.direction).to eq(initial_position.direction)
        end
      end
    end
  end

  describe '.command_regex' do
    it 'matches MOVE command' do
      expect('MOVE').to match(described_class.command_regex)
    end
  end
end
