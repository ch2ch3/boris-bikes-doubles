class Van

	include BikeContainer

	def dock_all_broken_bikes_from(station)
		@bikes.concat( station.release_broken_bikes )
	end

	def drop_off_broken_bikes_at(garage)
		release_broken_bikes.each do |broken_bike|
			garage.dock(broken_bike)
		end
	end

	def dock_all_fixed_bikes_from(garage)
		garage.release_fixed_bikes.each do |fixed_bike|
			dock(fixed_bike)
		end
	end
end