require 'garage'

describe Garage do

	let(:bike) { double :bike }
	let(:garage) { Garage.new }

	it "can fix bikes" do
		expect(bike).to receive(:fix!)
		garage.dock(bike)
	end

	it "has no broken bikes after fixing them" do
		expect(bike).to receive(:fix!)
		garage.dock(bike)
		expect(bike).to receive(:working?).and_return(true)
		expect(garage.broken_bikes).to eq []
	end

end