require 'person'

describe Person do

	let(:bike)             { double :bike     }
	let(:person)           { Person.new       }
	let(:person_with_bike) { Person.new(bike) }
	let(:station)          { double :station  }

	it "has no bike" do
		expect(person).not_to have_bike
	end

	it "can have a bike" do
		expect(person_with_bike).to have_bike
	end

	it "can break a bike" do
		expect(bike).to receive(:break!)
		person_with_bike.crash!
	end

	it "can rent a bike" do
		expect(station).to receive(:release_bike).and_return(bike)
		person.rent_bike_from(station)
	end

	it "has a bike after renting one" do
		allow(station).to receive(:release_bike).and_return(bike)
		person.rent_bike_from(station)
		expect(person.has_bike?).to eq true
	end

	it "can return a bike" do
		expect(station).to receive(:dock).with(bike)
		person_with_bike.return_bike_to(station)
	end

	it "doesn't have a bike after returning one" do
		allow(station).to receive(:dock).with(bike)
		person_with_bike.return_bike_to(station)
		expect(person_with_bike.has_bike?).to eq false
	end

	it "can't rent a bike if it already has one" do
		expect{person_with_bike.rent_bike_from(station)}.to raise_error(GreedyPersonError)
	end

end