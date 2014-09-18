require 'garage'
require 'metadata_spec'
require 'bike_container_spec'

describe Garage do

	let(:bike)   { double :bike, class: Bike, fix!: nil }
	let(:garage) { Garage.new                           }

	it_behaves_like "a thing"
	it_behaves_like "a bike container"

	it "can fix bikes" do
		expect(bike).to receive(:fix!)
		garage.dock(bike)
	end

	it "has no broken bikes after fixing them" do
		garage.dock(bike)
		allow(bike).to receive(:working?).and_return true
		expect(garage.broken_bikes).to eq []
	end

end