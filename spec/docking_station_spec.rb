require 'docking_station'
require 'timecop'
require 'metadata_spec'
require 'bike_container_spec'

describe DockingStation do

	let(:bike)				  { Bike.new }
	let(:station)             { DockingStation.new 				     }
	let(:station_with_bike)   { DockingStation.new(:bikes => [bike]) }

	it_behaves_like "a thing"
	it_behaves_like "a bike container"

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