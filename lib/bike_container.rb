module BikeContainer

	DEFAULT_CAPACITY = 20
	IS_WORKING = ->(bike) { bike.working? }

	def initialize(options = {})
		@bikes = options.fetch(:bikes, bikes)
		@capacity = options.fetch(:capacity, DEFAULT_CAPACITY)
	end

	def bikes
		@bikes ||= []
	end

	def dock(bike)
		raise ContainerFullError.new("#{self.class} has no more space.") if full?
		raise NotBikeError.new("The Person might be pretty cool, bu
			t actually not a bike.") if bike.class != Bike
		bikes << bike
		nil
	end

	def release_bike
		raise ContainerEmptyError.new("#{self.class} has no bikes to release.") if bikes.empty?
		bikes.delete(available_bikes.pop)
	end

	def full?
		bikes.count == @capacity
	end

	def available_bikes
		bikes.select(&IS_WORKING)
	end

	def broken_bikes
		bikes.reject(&IS_WORKING)
	end

	def release_broken_bikes
		bikes = broken_bikes
		@bikes.keep_if(&IS_WORKING)
		bikes
	end	
end