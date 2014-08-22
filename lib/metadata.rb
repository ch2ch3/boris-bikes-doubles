module Metadata

	attr_reader :serial_number

	LETTERS = ('A'..'Z').to_a
	NUMBERS = (0..9).to_a

	def initialize
		@serial_number = set_serial_number
	end

	def set_serial_number
		(0...3).map { |x| LETTERS.sample }.join + "-" + (0...5).map { |n| NUMBERS.sample }.join
	end

end