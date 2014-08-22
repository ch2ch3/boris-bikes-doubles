require 'van'
require 'metadata_spec'
require 'bike_container_spec'

describe Van do

	let(:broken_bike)          { Bike.new.break!               }
	let(:fixed_bike)           { Bike.new.break!.fix!          }	
	let(:van) 		           { Van.new                       }
	let(:van_with_broken_bike) { Van.new(bikes: [broken_bike]) }
	let(:van_with_fixed_bike)  { Van.new(bikes: [fixed_bike])  }
	let(:station)              { double :station               }
	let(:garage)               { double :garage                }

	it_behaves_like "a thing"
	it_behaves_like "a bike container"

	it 'should ask the station to release all broken bikes' do
		expect(station).to receive(:release_broken_bikes).and_return([broken_bike])
		van.dock_all_broken_bikes_from(station)
	end

	it 'should have broken bikes after collecting them' do
		allow(station).to receive(:release_broken_bikes).and_return([broken_bike])
		van.dock_all_broken_bikes_from(station)
		expect(broken_bike).to receive(:working?).and_return(false)
		expect(van.broken_bikes).to eq [broken_bike]
	end

	it 'should drop off broken bikes at the garage' do
		expect(garage).to receive(:dock).with(broken_bike)
		van_with_broken_bike.drop_off_broken_bikes_at(garage)
	end

	it "should have no broken bikes after dropping off the last one" do
		expect(garage).to receive(:dock).with(broken_bike)
		van_with_broken_bike.drop_off_broken_bikes_at(garage)
		expect(van_with_broken_bike.broken_bikes).to eq []
	end

	it 'should pick up the fixed bikes from the garage' do
		expect(garage).to receive(:release_fixed_bikes).and_return([fixed_bike])
		van.dock_all_fixed_bikes_from(garage)
	end

	it "should drop off fixed bikes at docking stations" do
		expect(station).to receive(:bikes).and_return([])
		van_with_fixed_bike.drop_off_fixed_bikes_at(station)
	end

	it "should have no fixed bikes after dropping off the last one" do
		allow(station).to receive(:bikes).and_return([])
		van_with_fixed_bike.drop_off_fixed_bikes_at(station)
		expect(van_with_fixed_bike.available_bikes).to eq []
	end

end