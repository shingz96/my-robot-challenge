require 'rspec'
require_relative '../../lib/table'
require_relative '../../lib/robot'
require_relative '../../lib/commander'

RSpec.describe Commander do
  let(:table) { Table.new(5, 5) }
  let(:robot) { Robot.new(table) }

  describe '#initialize' do
    subject(:commander) { described_class.new(robot) }

    it 'creates a Commander object with the given robot' do
      expect(commander).to be_a(Commander)
      expect(commander.instance_variable_get(:@robot)).to eq(robot)
    end

    context 'when the robot is not a Robot object' do
      let(:robot) { 'robot' }

      it 'raises an ArgumentError' do
        expect { commander }.to raise_error(ArgumentError, 'Robot must be a Robot object')
      end
    end
  end

  describe '#run' do
    let(:commander) { described_class.new(robot, output: output) }
    let(:output) { StringIO.new }

    subject(:run_command) { commander.run(command) }

    context 'when the command is PLACE' do
      let(:command) { 'PLACE 0,0,NORTH' }

      it "invokes robot's place method" do
        expect(robot).to receive(:place).with(0, 0, 'NORTH')
        run_command
      end
    end

    context 'when the command is MOVE' do
      let(:command) { 'MOVE' }

      it "invokes robot's move method" do
        expect(robot).to receive(:move)
        run_command
      end
    end

    context 'when the command is LEFT' do
      let(:command) { 'LEFT' }

      it "invokes robot's left method" do
        expect(robot).to receive(:left)
        run_command
      end
    end

    context 'when the command is RIGHT' do
      let(:command) { 'RIGHT' }

      it "invokes robot's right method" do
        expect(robot).to receive(:right)
        run_command
      end
    end

    context 'when the command is REPORT' do
      let(:command) { 'REPORT' }

      it "invokes robot's report method" do
        expect(robot).to receive(:report)
        run_command
      end
    end

    context 'when the command is invalid' do
      let(:command) { 'JUMP' }

      it 'prints an error message' do
        expect(output).to receive(:puts).with("Invalid command: #{command}")
        run_command
      end
    end

    context 'when an unexpected error occurs' do
      let(:command) { 'PLACE 0,0,NORTH' }
      let(:error_message) { 'Something went wrong' }

      before do
        allow(robot).to receive(:place).and_raise(StandardError, error_message)
      end

      it 'prints an error message' do
        expect(output).to receive(:puts).with("Unexpected error: #{error_message}")
        run_command
      end
    end
  end
end
