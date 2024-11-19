require 'rspec'
require_relative '../../../../lib/toy/commands/report'
require_relative '../../../../lib/toy/robot'
require_relative '../../../../lib/toy/table'
require_relative '../../../../lib/toy/position'

RSpec.describe Toy::Commands::Report do
  describe '#execute' do
    let(:table) { Toy::Table.new(5, 5) }
    let(:robot) { Toy::Robot.new }
    let(:command) { 'REPORT' }
    let(:output) { StringIO.new }

    subject(:report_command) { described_class.new(robot: robot, table: table, command: command, output: output).execute }

    context 'when the robot is not placed on the table' do
      it 'does not report the position' do
        expect(report_command).to eq(nil)
      end
    end

    context 'when the robot is placed on the table' do
      let(:initial_position) { Toy::Position.new(x: 0, y: 0, direction: 'NORTH') }

      before do
        robot.position = initial_position
      end

      it "reports robot's position" do
        expect(output).to receive(:puts).with("#{initial_position.x},#{initial_position.y},#{initial_position.direction}")
        report_command
      end
    end
  end

  describe '.command_regex' do
    it 'matches REPORT command' do
      expect('REPORT').to match(described_class.command_regex)
    end
  end
end
