class Bike

	attr_reader :serial_number
	attr_accessor :rented_at
	
	LETTERS = ('A'..'Z').to_a
	NUMBERS = (0..9).to_a

	def initialize
		self.fix!
		@serial_number = set_serial_number
		@birth_time = Time.now
		@rented_at = nil
	end

	def set_serial_number
		(0...3).map { |x| LETTERS.sample }.join + "-" + (0...5).map { |n| NUMBERS.sample }.join
	end

	def working?
		wear_and_tear
		@working
	end

	def wear_and_tear
		@working = false if (Time.now - @birth_time) > 63070000
	end

	def break!
		@working = false
		self
	end

	def fix!
		@working = true
		self
	end

end