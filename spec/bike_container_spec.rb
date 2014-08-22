require 'bike_container'

class Container; include BikeContainer; end

shared_examples "a bike container" do

	let(:bike)               { Bike.new 									}
	let(:broken_bike)        { Bike.new.break!								}
	let(:holder)             { Container.new   						        }
	let(:holder_with_bikes)  { Container.new(:bikes => [bike, broken_bike]) }

	def fill_holder(holder)
		20.times { holder.dock(bike) }
	end

	it "has a location" do
		expect(holder.postal_code.nil?).to eq false
	end

	it "has the postal code of its location" do
		expect(holder.postal_code).to match(/(((N|S)W|(E|W)C)|(^N|^S|^E|^W))\d{1}/)
		# only matches N, S, E, W, NW, SW, EC, WC
	end

	it "has no bikes" do
		expect(holder.bikes).to eq []
	end

	it "can accept a bike" do
		expect(holder.dock(bike)).to eq nil
	end

	it "has a bike after it docks it" do
		holder.dock(bike)
		expect(holder.bikes).to eq [bike]
	end

	it "can release a bike" do
		holder.dock(bike)
		expect(holder.release_bike).to eq bike
	end

	it "has no bikes after releasing the last one" do
		holder.dock(bike)
		holder.release_bike
		expect(holder.bikes).to eq []
	end

	it "should know when it's full" do
		expect(holder).not_to be_full
		fill_holder(holder)
		expect(holder).to be_full
	end

	it "should provide the list of available bikes" do
		expect(holder_with_bikes.available_bikes).to eq [bike]
	end

	it "should provide the list of broken bikes" do
		expect(holder_with_bikes.broken_bikes).to eq [broken_bike]
	end

	it "can release the broken bikes" do
		expect(holder_with_bikes.release_broken_bikes).to eq [broken_bike]
	end

	it "has no broken bikes after releasing them" do
		holder_with_bikes.release_broken_bikes
		expect(holder_with_bikes.broken_bikes).to eq []
	end

	context "errors" do

		it "should not accept a bike if it's full" do
			fill_holder(holder)
			expect{ holder.dock(bike) }.to raise_error(ContainerFullError)
		end

		it "should not release bikes if it's empty" do
			expect{ holder.release_bike }.to raise_error(ContainerEmptyError)
		end

		it "should not dock non-bikes" do
			vincent = double :person
			expect{ holder.dock(vincent) }.to raise_error(NotBikeError)
		end

	end

end