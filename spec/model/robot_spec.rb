require "model/robot"

RSpec.describe Robot do
  describe "#report" do
  	let(:x) { 1 }
  	let(:y) { 1 }
  	let(:direction) { 'EAST' }

  	subject do 
  		described_class.new(x: x, y: y, direction: direction).report
  	end

    it "should report the robot position" do
      expect(subject).to eq([x, y, direction])
    end
  end

  describe "#turn_left" do
  	let(:x) { 1 }
  	let(:y) { 1 }
  	let(:direction) { 'EAST' }
  	let(:new_direction) { 'NORTH' }
  	let(:robot) { described_class.new(x: x, y: y, direction: direction) }
  	before do
  		robot.turn_left
  	end
    it "should report the robot position" do
      expect(robot.report).to eq([x, y, new_direction])
    end
  end

  describe "#turn_right" do
  	let(:x) { 1 }
  	let(:y) { 1 }
  	let(:direction) { 'EAST' }
  	let(:new_direction) { 'SOUTH' }
  	let(:robot) { described_class.new(x: x, y: y, direction: direction) }
  	before do 
  		robot.turn_right
  	end

    it "should report the robot position" do
      expect(robot.report).to eq([x, y, new_direction])
    end
  end

  describe "#move" do
  	context 'valid movement' do
	  	let(:x) { 1 }
			let(:y) { 1 }
			let(:direction) { 'EAST' }
			let(:robot) { described_class.new(x: x, y: y, direction: direction) }
			before do
				robot.move
			end

  		it "should report the robot position" do
     		expect(robot.report).to eq([x+1, y, direction])
    	end
  	end

		context 'invalid movement' do
			context 'when negative x position value' do
				let(:x) { 0 }
				let(:y) { 1 }
				let(:direction) { 'WEST' }
				let(:robot) { described_class.new(x: x, y: y, direction: direction) }
				before do
					robot.move
				end
	  		it "should report the unmoved robot position" do
	     		expect(robot.report).to eq([x, y, direction])
	    	end	
			end

			context 'when negative y position value' do
				let(:x) { 0 }
				let(:y) { 0 }
				let(:direction) { 'SOUTH' }
				let(:robot) { described_class.new(x: x, y: y, direction: direction) }
				before do
					robot.move
				end
	  		it "should report the unmoved robot position" do
	     		expect(robot.report).to eq([x, y, direction])
	    	end	
			end
  	end
  end
end