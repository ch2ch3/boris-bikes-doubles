require 'garage'
require 'metadata_spec'

describe Garage do

	let(:bike)   { Bike.new   }
	let(:garage) { Garage.new }

	it_behaves_like "a thing"

	it "can fix bikes" do
		garage.dock(bike)
		expect(bike).to be_working
	end

	it "has no broken bikes after fixing them" do
		garage.dock(bike)
		expect(garage.broken_bikes).to eq []
	end

end