#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative '../app/model/board'
require_relative '../app/model/robot'
require_relative '../lib/parser/txt_parser'
require_relative '../lib/command_executor'

puts '----------'
puts 'Game Start'
puts '----------'
puts 'Initialising Board'
puts '----------'
board = Board.new
puts '----------'
puts "Parsing Commands"
puts '----------'
commands = TXTParser.parse
puts '----------'
puts "Executing Command's"
puts '----------'
CommandExecutor.new(commands: commands, board: board).run