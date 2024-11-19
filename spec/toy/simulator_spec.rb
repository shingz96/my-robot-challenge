require 'rspec'
require_relative '../../toy/simulator'

RSpec.describe Toy::Simulator do
  describe '#run' do
    let(:simulator) { described_class.new(input, output) }
    let(:input) { StringIO.new(commands) }
    let(:output) { StringIO.new }
    let(:commands) do
      <<~COMMANDS
        PLACE 0,0,NORTH
        MOVE
        LEFT
        RIGHT
        REPORT
      COMMANDS
    end

    it 'pass the given commands to Commander' do
      expect_any_instance_of(Toy::Commander).to receive(:run).with('PLACE 0,0,NORTH', instance_of(Toy::Formatter::Output))
      expect_any_instance_of(Toy::Commander).to receive(:run).with('MOVE', instance_of(Toy::Formatter::Output))
      expect_any_instance_of(Toy::Commander).to receive(:run).with('LEFT', instance_of(Toy::Formatter::Output))
      expect_any_instance_of(Toy::Commander).to receive(:run).with('RIGHT', instance_of(Toy::Formatter::Output))
      expect_any_instance_of(Toy::Commander).to receive(:run).with('REPORT', instance_of(Toy::Formatter::Output))
      simulator.run
    end

    context 'when the command is EXIT' do
      let(:commands) { "EXIT" }

      shared_examples 'exits the simulator' do
        it 'exits the simulator' do
          expect(output).to receive(:puts).with("Robot Simulator started. Enter commands (Ctrl-C or EXIT to exit):")
          expect(output).to receive(:puts).with("Commands: PLACE X,Y,F | MOVE | LEFT | RIGHT | REPORT")
          expect(output).to receive(:puts).with( "-" * 50)

          expect(output).to receive(:puts).with( "-" * 50)
          expect(output).to receive(:puts).with("Robot Simulator ended.")
          simulator.run
        end
      end

      context 'when the input is from terminal' do
        let(:input) { double('input') }

        before do
          allow(input).to receive(:isatty) { true }
          allow(input).to receive(:gets) { commands }
        end

        it_behaves_like 'exits the simulator'
      end

      context 'when the input is from file' do
        let(:input) { StringIO.new(commands) }

        it_behaves_like 'exits the simulator'
      end
    end

    shared_examples 'reports the robot position correctly' do
      it 'reports the robot position correctly' do
        expect(output).to receive(:puts).with("Robot Simulator started. Enter commands (Ctrl-C or EXIT to exit):")
        expect(output).to receive(:puts).with("Commands: PLACE X,Y,F | MOVE | LEFT | RIGHT | REPORT")
        expect(output).to receive(:puts).with( "-" * 50)

        expect(output).to receive(:puts).with(report_message)

        expect(output).to receive(:puts).with( "-" * 50)
        expect(output).to receive(:puts).with("Robot Simulator ended.")
        simulator.run
      end
    end

    context 'test case 1' do
      let(:commands) do
        <<~COMMANDS
          PLACE 0,0,NORTH
          MOVE
          REPORT
        COMMANDS
      end

      it_behaves_like 'reports the robot position correctly' do
        let(:report_message) { "0,1,NORTH" }
      end
    end

    context 'test case 2' do
      let(:commands) do
        <<~COMMANDS
          PLACE 0,0,NORTH
          LEFT
          REPORT
        COMMANDS
      end

      it_behaves_like 'reports the robot position correctly' do
        let(:report_message) { "0,0,WEST" }
      end
    end

    context 'test case 3' do
      let(:commands) do
        <<~COMMANDS
          PLACE 1,2,EAST
          MOVE
          MOVE
          LEFT
          MOVE
          REPORT
        COMMANDS
      end

      it_behaves_like 'reports the robot position correctly' do
        let(:report_message) { "3,3,NORTH" }
      end
    end
  end
end
