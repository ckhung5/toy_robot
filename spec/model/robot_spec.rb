require "model/robot"

RSpec.describe Robot do
  describe "#report" do
  	let(:x) { 1 }
  	let(:y) { 1 }
  	let(:direction) { 'east' }

  	subject do 
  		described_class.new(x: x, y: y, direction: direction).report
  	end

    it "should report the robot position" do
      expect(subject).to eq([x, y, direction])
    end
  end
end