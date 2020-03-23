require "model/board"
require "model/robot"

RSpec.describe Board do
  let(:max_board_size) { 6 }

  describe "#add_robot" do
  	let(:x) { 1 }
  	let(:y) { 1 }
  	let(:direction) { 'EAST' }
    let(:robot) { Robot.new(x: x, y: y, direction: direction, max_board_size: max_board_size) }
    let(:board) { described_class.new }

    before do 
      board.add_robot(robot)
    end

    it "should add a new robot" do
      expect(board.robots).to eq([robot])
    end
  end

  describe "#existing_robot" do
    context 'when there is no existing robot' do
      let(:x) { 1 }
      let(:y) { 1 }
      let(:board) { described_class.new }
      
      subject { board.exisiting_robot?(x: x, y: y)}
      it "should return false" do
        expect(subject).to eq(false)
      end
    end

    context 'when there is existing robot' do
      let(:x) { 1 }
      let(:y) { 1 }
      let(:direction) { 'EAST' }
      let(:robot) { Robot.new(x: x, y: y, direction: direction, max_board_size: max_board_size) }
      let(:board) { described_class.new }
      
      before do
        board.add_robot(robot)
      end

      subject { board.exisiting_robot?(x: x, y: y)}
      it "should return true" do
        expect(subject).to eq(true)
      end
    end
  end
end