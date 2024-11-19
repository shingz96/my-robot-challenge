require 'rspec'
require_relative '../../../../lib/toy/commands/place'
require_relative '../../../../lib/toy/robot'
require_relative '../../../../lib/toy/table'
require_relative '../../../../lib/toy/position'

RSpec.describe Toy::Commands::Place do
  describe '#execute' do
    let(:table) { Toy::Table.new(5, 5) }
    let(:robot) { Toy::Robot.new }
    let(:command) { 'PLACE 0,0,NORTH' }
    let(:output) { Toy::Formatter::Output.new }

    subject(:place_command) { described_class.new(robot: robot, table: table, command: command, output: output).execute }

    it 'places the robot on the table' do
      place_command

      expect(robot.placed?).to eq(true)
      expect(robot.position.x).to eq(0)
      expect(robot.position.y).to eq(0)
      expect(robot.position.direction).to eq('NORTH')
    end

    context 'when the position is invalid' do
      let(:command) { 'PLACE 6,6,NORTH' }

      it 'raise invalid position error' do
        expect { place_command }.to raise_error(Toy::Errors::InvalidPositionError)
      end
    end

    context 'when the command is invalid' do
      let(:command) { 'PLACE 0,0,LEFT' }

      it 'raise invalid direction error' do
        expect { place_command }.to raise_error(Toy::Errors::InvalidPositionArgumentError)
      end
    end
  end

  describe '.command_regex' do
    it 'matches PLACE command' do
      expect('PLACE 0,0,NORTH').to match(described_class.command_regex)
      expect('PLACE 1,1,EAST').to match(described_class.command_regex)
      expect('PLACE 2,2,SOUTH').to match(described_class.command_regex)
      expect('PLACE 3,3,WEST').to match(described_class.command_regex)
    end
  end
end
