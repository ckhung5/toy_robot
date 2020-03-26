# frozen_string_literal: true

require 'model/board'
require 'model/robot'

RSpec.describe Board do
  let(:max_board_size) { 6 }
  let(:name) { 'Alice' }
  describe '#add_robot' do
    let(:x) { 1 }
    let(:y) { 1 }
    let(:direction) { 'EAST' }
    let(:robot) { Robot.new(name: name, x: x, y: y, direction: direction, max_board_size: max_board_size) }
    let(:board) { described_class.new }

    before do
      board.add_robot(robot)
    end

    it 'should add a new robot' do
      expect(board.robots).to eq([robot])
    end

    context 'when there is a same robot' do
      it 'should not add the duplicate robot' do
        board.add_robot(robot)
        expect(board.robots).to eq([robot])
        expect(board.robots.count).to eq(1)
      end
    end
  end

  describe '#existing_robot' do
    context 'when there is no existing robot' do
      let(:x) { 1 }
      let(:y) { 1 }
      let(:board) { described_class.new }

      subject { board.existing_robot?(x: x, y: y) }
      it 'should return false' do
        expect(subject).to eq(false)
      end
    end

    context 'when there is existing robot' do
      let(:x) { 1 }
      let(:y) { 1 }
      let(:direction) { 'EAST' }
      let(:robot) { Robot.new(name: name, x: x, y: y, direction: direction, max_board_size: max_board_size) }
      let(:board) { described_class.new }

      before do
        board.add_robot(robot)
      end

      subject { board.existing_robot?(x: x, y: y) }
      it 'should return true' do
        expect(subject).to eq(true)
      end
    end
  end

  describe '#find_robot' do
    let(:x) { 1 }
    let(:y) { 1 }
    let(:direction) { 'EAST' }
    let(:robot) { Robot.new(name: name, x: x, y: y, direction: direction, max_board_size: max_board_size) }
    let(:board) { described_class.new }

    before do
      board.add_robot(robot)
    end

    it 'should add a new robot' do
      expect(board.find_robot(name: name)).to eq(robot)
    end
  end
end
