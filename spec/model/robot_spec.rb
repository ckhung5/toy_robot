# frozen_string_literal: true

require 'model/robot'
require 'model/board'

RSpec.describe Robot do
  let(:max_board_size) { 6 }
  let(:name) { 'Alice' }

  describe '#action' do
    context 'report' do
      let(:x) { 1 }
      let(:y) { 1 }
      let(:direction) { 'EAST' }

      subject do
        described_class.new(
          name: name, x: x, y: y, direction: direction, max_board_size: max_board_size
        ).action('REPORT', nil)
      end

      it 'should report the robot position' do
        expect(subject).to eq("#{name}: #{x},#{y},#{direction}")
      end
    end

    context 'turn_left' do
      let(:x) { 1 }
      let(:y) { 1 }
      let(:direction) { 'EAST' }
      let(:new_direction) { 'NORTH' }
      let(:robot) { described_class.new(name: name, x: x, y: y, direction: direction, max_board_size: max_board_size) }
      subject do
        robot.action('LEFT', nil)
      end
      it 'should report the robot position' do
        subject
        expect(robot.action('REPORT', nil)).to eq("#{name}: #{x},#{y},#{new_direction}")
      end
    end

    context 'turn_right' do
      let(:x) { 1 }
      let(:y) { 1 }
      let(:direction) { 'EAST' }
      let(:new_direction) { 'SOUTH' }
      let(:robot) { described_class.new(name: name, x: x, y: y, direction: direction, max_board_size: max_board_size) }
      subject do
        robot.action('RIGHT', nil)
      end

      it 'should report the robot position' do
        subject
        expect(robot.action('REPORT', nil)).to eq("#{name}: #{x},#{y},#{new_direction}")
      end
    end

    context 'move' do
      subject do
        robot.action('MOVE', board)
      end

      let(:board) { Board.new }

      context 'valid movement' do
        let(:x) { 1 }
        let(:y) { 1 }
        let(:direction) { 'EAST' }
        let(:robot) { described_class.new(name: name, x: x, y: y, direction: direction, max_board_size: max_board_size) }

        it 'should report the robot position' do
          subject
          expect(robot.action('REPORT', nil)).to eq("#{name}: #{x + 1},#{y},#{direction}")
        end
      end

      context 'invalid movement' do
        context 'when negative x position value' do
          let(:x) { 0 }
          let(:y) { 1 }
          let(:direction) { 'WEST' }
          let(:robot) do
            described_class.new(name: name, x: x, y: y, direction: direction, max_board_size: max_board_size)
          end

          it 'should report the unmoved robot position' do
            subject
            expect(robot.action('REPORT', nil)).to eq("#{name}: #{x},#{y},#{direction}")
          end
        end

        context 'when negative y position value' do
          let(:x) { 0 }
          let(:y) { 0 }
          let(:direction) { 'SOUTH' }
          let(:robot) do
            described_class.new(name: name, x: x, y: y, direction: direction, max_board_size: max_board_size)
          end

          it 'should report the unmoved robot position' do
            subject
            expect(robot.action('REPORT', nil)).to eq("#{name}: #{x},#{y},#{direction}")
          end
        end

        context 'when it is not place correctly with no direction' do
          let(:x) { 0 }
          let(:y) { 0 }
          let(:robot) do
            described_class.new(name: name, x: x, y: y, max_board_size: max_board_size)
          end

          it 'should report the unmoved robot position' do
            subject
            expect(robot.action('REPORT', nil)).to eq("#{name}: #{x},#{y},")
          end
        end
      end
    end
  end
end
