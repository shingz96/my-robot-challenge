require 'rspec'
require_relative '../../../lib/toy/table'
require_relative '../../../lib/toy/robot'
require_relative '../../../lib/toy/commander'

RSpec.describe Toy::Commander do
  let(:table) { Toy::Table.new(5, 5) }
  let(:robot) { Toy::Robot.new }
  let(:commander) { described_class.new(robot: robot, table: table) }

  describe '#initialize' do
    it 'creates a Commander object with the given robot and table' do
      expect(commander).to be_a(Toy::Commander)
      expect(commander.instance_variable_get(:@robot)).to eq(robot)
      expect(commander.instance_variable_get(:@table)).to eq(table)
    end
  end

  describe '#run' do
    subject(:run_command) { commander.run(command, output) }

    let(:output) { Toy::Formatter::Output.new }

    shared_examples 'execute command correctly' do
      it "execute command correctly" do
        expect(command_class).to receive(:new).with(robot: robot, table: table, command: command, output: output).and_call_original
        expect_any_instance_of(command_class).to receive(:execute)
        run_command
      end
    end

    context 'when the command is PLACE' do
      let(:command) { 'PLACE 0,0,NORTH' }
      let(:command_class) { Toy::Commands::Place }

      it_behaves_like 'execute command correctly'

      context 'when no values passed' do
        let(:command) { 'PLACE' }

        it 'does not execute any command' do
          expect(command_class).not_to receive(:new)
          expect(output).to receive(:print_error).with(Toy::Errors::InvalidCommandError)
          run_command
        end
      end
    end

    context 'when the command is MOVE' do
      let(:command) { 'MOVE' }
      let(:command_class) { Toy::Commands::Move }

      it_behaves_like 'execute command correctly'
    end

    context 'when the command is LEFT' do
      let(:command) { 'LEFT' }
      let(:command_class) { Toy::Commands::Left }

      it_behaves_like 'execute command correctly'
    end

    context 'when the command is RIGHT' do
      let(:command) { 'RIGHT' }
      let(:command_class) { Toy::Commands::Right }

      it_behaves_like 'execute command correctly'
    end

    context 'when the command is REPORT' do
      let(:command) { 'REPORT' }
      let(:command_class) { Toy::Commands::Report }

      it_behaves_like 'execute command correctly'
    end

    context 'when the command is invalid' do
      let(:command) { 'JUMP' }

      it 'does not execute any command' do
        expect(output).to receive(:print_error).with(Toy::Errors::InvalidCommandError)
        run_command
      end
    end
  end
end
