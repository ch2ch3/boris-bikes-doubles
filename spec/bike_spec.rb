require 'bike'

describe Bike do

	let(:bike) { Bike.new }

	context "at initialisation" do

		it "works" do
			expect(bike).to be_working
		end

		it "has a serial number" do
			expect(bike.serialnumber).to match(/^[A-Z]{3}-\d{5}$/)
		end

		it "has a unique serial number" do
			expect(bike.serialnumber).not_to eq Bike.new.serialnumber
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

	xit "breaks after 2 years" do
		Timecop.travel(Time.local(2013,1,1))
		bike = Bike.new
		Timecop.travel(Time.local(2013,1,3))
		expect(bike.working?).to eq false
	end

end