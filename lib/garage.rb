class Garage

	include BikeContainer

	def dock(bike)
		super
		bike.fix!
	end

	def release_fixed_bikes
		bikes = available_bikes
		@bikes.delete_if(&IS_WORKING)
		bikes
	end

end