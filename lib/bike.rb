class Bike

	attr_reader :serialnumber
	attr_accessor :rented_at
	
	LETTERS = ('A'..'Z').to_a
	NUMBERS = (0..9).to_a

	def initialize
		self.fix!
		@serialnumber = set_serialnumber
		@birthtime = Time.now
		@rented_at = nil
		@last_serviced = nil
	end

	def rented_at=(value)
		@rented_at = value
	end	

	def set_serialnumber
		(0...3).map { |x| LETTERS.sample }.join + "-" + (0...5).map { |n| NUMBERS.sample }.join
	end

	def working?
		wear_and_tear
		@working
	end

	def wear_and_tear
		@working = false if (Time.now - @birthtime) > 63070000
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