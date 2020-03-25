require 'command_executor'
require_relative "../../app/model/board"

RSpec.describe CommandExecutor do
	describe '#run' do
		let(:board) { Board.new }
	  let(:executor) do 
	  	CommandExecutor.new(commands: {'ALICE' =>['0,0,NORTH', 'REPORT']},board: board)
	  end
	  subject do
	  	executor.run
	  end
	  it 'should add the robot into the board' do
	  	subject
	  	expect(board.robots.count).to eq(1)
	  end

	  it 'should not raise any error' do
	  	expect {subject}.not_to raise_error
	  end

	  context 'when the board is not initialise' do
	  	let(:executor) do 
	  		CommandExecutor.new(commands: {'ALICE' =>['0,0,NORTH', 'REPORT']},board: nil)
	  	end

	  	it 'should raise an error' do
	  		expect {subject}.to raise_error('Board is not initialize')
	  	end
	  end

	  context 'when one of the robots is not initialise yet' do
	  	let(:executor) do 
	  		CommandExecutor.new(
	  			commands: {
	  				'ALICE' =>['0,0,NORTH', 'REPORT'],
	  				'BRUCE' =>['REPORT']
	  			},
	  			board: board
	  		)
	  	end

	  	it 'should raise an error' do
	  		expect {subject}.to raise_error('Robot is not initilise properly to do command')
	  	end
		end

	  context 'when one of the robots collide while placing' do
	  	let(:executor) do 
	  		CommandExecutor.new(
	  			commands: {
	  				'ALICE' =>['0,0,NORTH', 'REPORT'],
	  				'BRUCE' =>['0,0,NORTH', 'REPORT']
	  			},
	  			board: board
	  		)
	  	end

	  	it 'should raise an error' do
	  		expect {subject}.to raise_error("Could not place new robot on position x:0, y:0 as there is an existing one")
	  	end
		end
	end
end