require 'docking_station'

describe DockingStation do

	let(:bike)               { double :bike, working?: true  }
	let(:broken_bike)        { double :bike, working?: false }
	let(:station)            { DockingStation.new            }
	let(:station_with_bikes) { DockingStation.new(:bikes => [bike, broken_bike]) }

	def fill_station(station)
		20.times { station.dock(double :bike) }
	end

	it "has no bikes" do
		expect(station.bikes).to eq []
	end

	it "can accept a bike" do
		expect(station.dock(bike)).to eq nil
	end

	it "has a bike after it docks it" do
		station.dock(bike)
		expect(station.bikes).to eq [bike]
	end

	it "can release a bike" do
		station.dock(bike)
		expect(station.release_bike).to eq bike
	end

	it "has no bikes after releasing the last one" do
		station.dock(bike)
		station.release_bike
		expect(station.bikes).to eq []
	end

	it "should know when it's full" do
		expect(station).not_to be_full
		fill_station(station)
		expect(station).to be_full
	end

	it "should not accept a bike if it's full" do
		fill_station(station)
		expect{ station.dock(double :bike) }.to raise_error
	end

	it "should provide the list of available bikes" do
		expect(station_with_bikes.available_bikes).to eq [bike]
	end

	it "should provide the list of broken bikes" do
		expect(station_with_bikes.broken_bikes).to eq [broken_bike]
	end

	it "can release the broken bikes" do
		expect(station_with_bikes.release_broken_bikes).to eq [broken_bike]
	end

	it "has no broken bikes after releasing them" do
		station_with_bikes.release_broken_bikes
		expect(station_with_bikes.broken_bikes).to eq []
	end

end