require 'docking_station'
require 'Timecop'

describe DockingStation do

	let(:bike)				  { Bike.new }
	let(:station)             { DockingStation.new 				     }
	let(:station_with_bike)   { DockingStation.new(:bikes => [bike]) }

	it "has a location" do
		expect(station.postal_code.nil?).to eq false
	end

	it "has the postal code of its location" do
		expect(station.postal_code).to match(/([EW](C?)|([NS](W?)))\d{1}/)
	end

	it "knows what time the bike is rented out" do
		station_with_bike.release_bike
		expect(bike.rented_at).to eq Time.now.round(0)
	end

	it "can calculate the duration of rental" do
		Timecop.freeze(Time.local(2014))
		station_with_bike.release_bike
		Timecop.travel(1801)
		expect(STDOUT).to receive(:puts).with("You're late mate!")
		station.dock(bike)
	end

end