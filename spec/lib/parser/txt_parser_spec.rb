# frozen_string_literal: true

require 'parser/txt_parser'

RSpec.describe TXTParser do
  describe '#parse' do
    let(:expect_result) do
      {
        0 => { 'ALICE' => '0,0,NORTH' }, 1 => { 'ALICE' => 'MOVE' }, 2 => { 'ALICE' => 'REPORT' }
      }
    end

    it 'should return a list of commands for the robot' do
      expect(
        TXTParser.parse(filename: File.join(File.dirname(__FILE__), '../../test_files/command_test1.txt'))
      ).to eq(expect_result)
    end

    context 'when the robot name is invalid' do
      it 'should raise and error' do
        expect do
          TXTParser.parse(filename: File.join(File.dirname(__FILE__), '../../test_files/command_invalid_test.txt'))
        end.to raise_error('Robot name is not valid')
      end
    end
  end
end
