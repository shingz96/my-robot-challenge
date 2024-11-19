require 'rspec'
require_relative '../../../../lib/toy/commands/left'
require_relative '../../../../lib/toy/robot'
require_relative '../../../../lib/toy/table'
require_relative '../../../../lib/toy/position'

RSpec.describe Toy::Commands::Left do
  describe '#execute' do
    let(:table) { Toy::Table.new(5, 5) }
    let(:robot) { Toy::Robot.new }
    let(:command) { 'LEFT' }
    let(:output) { double('output') }

    subject(:left_command) { described_class.new(robot: robot, table: table, command: command, output: output).execute }

    context 'when the robot is not placed on the table' do
      it 'does not turn the robot to left' do
        left_command

        expect(robot.position).to eq(nil)
      end
    end

    context 'when the robot is placed on the table' do
      let(:initial_position) { Toy::Position.new(x: 0, y: 0, direction: 'NORTH') }
      let(:expected_position) { initial_position.left }

      before do
        robot.position = initial_position
      end

      it 'turns the robot to left' do
        left_command

        expect(robot.position.x).to eq(expected_position.x)
        expect(robot.position.y).to eq(expected_position.y)
        expect(robot.position.direction).to eq(expected_position.direction)
      end
    end
  end

  describe '.command_regex' do
    it 'matches LEFT command' do
      expect('LEFT').to match(described_class.command_regex)
    end
  end
end
