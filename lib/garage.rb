require_relative 'bike_container'

class Garage

	include BikeContainer

	def dock(bike)
		super
		bike.fix!
	end

end