# frozen_string_literal: true

require 'byebug'

module TXTParser
	PLACE_COMMAND_REGEX = /(\d{1},\d{1},[a-zA-Z]{4,5})/
	OTHER_COMMAND_REGEX = /: ([a-zA-Z]{4,6})/
  NAME_REGEX = /([a-zA-Z]{1,}):/

  class << self
  	def parse(filename: File.join(File.dirname(__FILE__), '../../feature/command.txt'))
	  	command = {}
	    File.foreach(filename) do |line|
	    	robot_name = name_capture(line)
	    	raise "Robot name is not valid" unless robot_name
	    	command[robot_name] ||= []
	      command[robot_name] += command_capture(line)
	    end
	    command
	  end

	  private

	  def command_capture(string)
	  	result = []
	  	[PLACE_COMMAND_REGEX, OTHER_COMMAND_REGEX].each do |regex|
	  		next if string.match(regex).nil?
	  		next if string.match(regex)[1] == 'PLACE'
	  		result.push(string.match(regex)[1])
	  	end
    	result
    end

    def name_capture(string)
	  	name = string.match(NAME_REGEX)
    	return if name.nil?
    	name[1]
    end
  end
end