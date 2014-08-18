require 'bike'

describe Bike do

	let(:bike) {Bike.new}

	context "at initialisation" do

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

end