module Metadata

	attr_reader :serial_number

	LETTERS = ('A'..'Z').to_a
	NUMBERS = (0..9).to_a

	def initialize(options = {})
		@serial_number = set_serial_number
	end

	def set_serial_number
		LETTERS.sample(3).join + "-" + NUMBERS.sample(5).join
	end

end