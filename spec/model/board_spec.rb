require "model/board"
require "model/robot"

RSpec.describe Board do
  describe "#add_robot" do
  	let(:x) { 1 }
  	let(:y) { 1 }
  	let(:direction) { 'EAST' }
    let(:robot) { Robot.new(x: x, y: y, direction: direction) }
    let(:board) { described_class.new }

    before do 
      board.add_robot(robot)
    end
    
    it "should add a new robot" do
      expect(board.robots).to eq([robot])
    end
  end
end