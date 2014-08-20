class DockingStation

	include BikeContainer

	attr_accessor :postal_code

	HALF_AN_HOUR = 30*60

	def initialize(options = {})
		@bikes = options.fetch(:bikes, bikes)
		@capacity = options.fetch(:capacity, DEFAULT_CAPACITY)
		@postal_code = options.fetch(:postal_code, "N1")
	end

	def dock(bike)
		begin
			raise LateMateError.new("You're late mate!") if rented_over_half_an_hour?(bike)
		rescue LateMateError => e
			puts e.message
		end
		super
	end

	def rented_over_half_an_hour?(bike)
		(Time.now - bike.rented_at) > HALF_AN_HOUR
	end

	def release_bike
		raise ContainerEmptyError.new("#{self.class} has no bikes to release.") if bikes.empty?
		bike = bikes.delete(available_bikes.pop)
		set_time(bike)
		bike
	end

	def set_time(bike)
		bike.rented_at = Time.now.round(0)
	end

end