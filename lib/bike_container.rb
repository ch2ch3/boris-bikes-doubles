require_relative 'exceptions'
require_relative 'metadata'

module BikeContainer

	include Metadata

	DEFAULT_CAPACITY = 20
	IS_WORKING = ->(bike) { bike.working? }

	attr_accessor :postal_code

	def initialize(options = {})
		@bikes = options.fetch(:bikes, bikes)
		@capacity = options.fetch(:capacity, DEFAULT_CAPACITY)
		@postal_code = options.fetch(:postal_code, "N1")
		super
	end

	def bikes
		@bikes ||= []
	end

	def dock(bike)
		raise ContainerFullError.new("#{self.class} has no more space.") if full?
		raise NotBikeError.new("The #{bike.class} might be pretty cool, but it's actually not a bike.") if bike.class != Bike
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

	def release_fixed_bikes
		bikes = available_bikes
		@bikes.delete_if(&IS_WORKING)
		bikes
	end

end