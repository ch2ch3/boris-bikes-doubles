require 'docking_station'
require 'timecop'
require 'metadata_spec'
require 'bike_container_spec'

describe DockingStation do

	let(:bike)				  { double :bike, class: Bike, working?: true }
	let(:station)             { DockingStation.new 				          }
	let(:station_with_bike)   { DockingStation.new(:bikes => [bike])      }

	it_behaves_like "a thing"
	it_behaves_like "a bike container"

	it "knows what time the bike is rented out" do
		expect(bike).to receive(:rented_at=).with(Time.now.round(0))
		station_with_bike.release_bike
	end

	it "can calculate the duration of rental" do
		allow(bike).to receive(:rented_at=).with(Time.local(2014))
		Timecop.freeze(Time.local(2014))
		station_with_bike.release_bike
		Timecop.travel(1801)
		allow(bike).to receive(:rented_at).and_return(Time.local(2014))
		expect(STDOUT).to receive(:puts).with("You're late mate!")
		station.dock(bike)
	end

end