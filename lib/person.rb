require_relative 'exceptions'

class Person

	def initialize(bike = nil)
		@bike = bike
	end

	def has_bike?
		!@bike.nil?
	end

	def crash!
		@bike.break!
	end

	def rent_bike_from(station)
		raise GreedyPersonError.new("One bike each you greedy prat!") if has_bike?
		@bike = station.release_bike
	end

	def return_bike_to(station)
		@bike = station.dock(@bike)
	end

end