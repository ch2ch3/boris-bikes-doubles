require 'bike'
require 'timecop'
require 'metadata_spec'

describe Bike do

	let(:bike) { Bike.new }

	context "at initialisation" do

		it_behaves_like "a thing"

		it "works" do
			expect(bike).to be_working
		end

	end

	it "can be broken" do
		bike.break!
		expect(bike).not_to be_working
	end

	it "can be fixed" do
		bike.break!.fix!
		expect(bike).to be_working
	end

	it "knows what time it was rented at" do
		station = DockingStation.new(:bikes => [bike])
		station.release_bike
		expect(bike.rented_at).to eq Time.now.round(0)
	end

	it "breaks down after 2 years" do
		Timecop.travel(Time.local(2010))
		bike = Bike.new
		Timecop.travel(Time.local(2013))
		expect(bike.working?).to eq false
	end

end