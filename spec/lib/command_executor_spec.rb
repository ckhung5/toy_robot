require 'command_executor'
require_relative "../../app/model/board"

RSpec.describe CommandExecutor do
	describe '#run' do
		let(:board) { Board.new }
	  let(:executor) do 
	  	CommandExecutor.new(commands: {
	        0=>{"ALICE"=>"0,0,NORTH"}, 1=>{"ALICE"=>"MOVE"}, 2=>{"ALICE"=>"REPORT"}
	      }, board: board
      )
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

	  context 'when one of the robots is not placed on the board yet' do
	  	let(:executor) do 
	  		CommandExecutor.new(
	  			commands: {
	  				0 => {
	  					'ALICE' =>'0,0,NORTH'
	  				},
	  				1 => {
	  					'ALICE' => 'REPORT'
	  				},
	  				2 => {
	  					'BRUCE' =>'REPORT'
	  				}
	  			},
	  			board: board
	  		)
	  	end

	  	it 'should not do any command for this robot' do
	  		subject
	  		expect(board.find_robot(name: 'BRUCE').unavailable_to_operate).to eq(true)
	  	end
		end

	  context 'when one of the robots collide while placing' do
	  	let(:executor) do 
	  		CommandExecutor.new(
	  			commands: {
	  				0 => {
							'ALICE' => '0,0,NORTH'
	  				},
	  				1 => {
	  					'ALICE' => 'REPORT'
	  				},
	  				2 => {
	  					'BRUCE' => '0,0,NORTH'
	  				},
	  				3 => {
	  					'BRUNCE' => 'REPORT'
	  				}
	  			},
	  			board: board
	  		)
	  	end

	  	it 'should be able to place BRUCE' do
	  		subject
	  		bruce_robot = board.find_robot(name: 'BRUCE')
	  		expect(bruce_robot.x).to eq(0)
	  		expect(bruce_robot.y).to eq(0)
	  		expect(bruce_robot.direction).to eq('NORTH')
	  	end
		end

		context 'when one of the robots collide while moving' do
	  	let(:executor) do 
	  		CommandExecutor.new(
	  			commands: {
	  				0 => {
	  					'ALICE' => '0,0,NORTH'
	  				},
	  				1 => {
	  					'ALICE' => 'MOVE'
	  				},
	  				2 => {
	  					'ALICE' => 'REPORT'
	  				},
	  				3 => {
	  					'BRUCE' => '0,0,NORTH'
	  				},
	  				4 => {
	  					'BRUCE' => 'MOVE'
	  				},
	  				5 => {
	  					'BRUCE' => 'REPORT'
	  				}
	  			},
	  			board: board
	  		)
	  	end

	  	it 'should not let BRUCE to run' do
	  		subject
	  		bruce_robot = board.find_robot(name: 'BRUCE')
	  		expect(bruce_robot.x).to eq(0)
	  		expect(bruce_robot.y).to eq(0)
	  		expect(bruce_robot.direction).to eq('NORTH')
	  	end
		end
	end
end