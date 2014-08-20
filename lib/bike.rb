class Bike

	attr_reader :serialnumber
	attr_accessor :rented_at

	def initialize
		self.fix!
		@serialnumber = set_serialnumber
		@rented_at = nil
	end

	def rented_at=(value)
		@rented_at = value
	end

	def set_serialnumber
		(0...3).map { |x| (('A'..'Z').to_a).sample }.join + "-" + (0...5).map { |n| ((0..9).to_a).sample }.join
	end

	def working?
		@working
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