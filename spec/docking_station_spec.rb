require 'docking_station'
require 'timecop'

describe DockingStation do

	let(:bike)				  { Bike.new }
	let(:station)             { DockingStation.new 				     }
	let(:station_with_bike)   { DockingStation.new(:bikes => [bike]) }

	it_behaves_like "a thing"

	it "has a location" do
		expect(station.postal_code.nil?).to eq false
	end

	it "has the postal code of its location" do
		expect(station.postal_code).to match(/(((N|S)W|(E|W)C)|(^N|^S|^E|^W))\d{1}/)
		# only matches N, S, E, W, NW, SW, EC, WC
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