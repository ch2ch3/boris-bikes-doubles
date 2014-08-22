class Bike

	attr_accessor :rented_at

	def initialize
		self.fix!
		@birth_time = Time.now
		@rented_at = nil
		super
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