class DockingStation

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
		raise "Station is full!" if full?
		bikes << bike
		nil
	end

	def release_bike
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