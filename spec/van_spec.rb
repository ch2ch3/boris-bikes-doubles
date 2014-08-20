require 'van'

describe Van do

	let(:broken_bike)    { double :bike, working?: false    }
	let(:fixed_bike)     { double :bike, working?: true     }
	let(:van) 		     { Van.new                          }
	let(:van_with_bikes) { Van.new(:bikes => [broken_bike]) }
	let(:station)        { double :station                  }
	let(:garage)         { double :garage                   }

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
		van_with_bikes.drop_off_broken_bikes_at(garage)
	end

	it 'should pick up the fixed bikes from the garage' do
		expect(garage).to receive(:release_fixed_bikes).and_return([fixed_bike])
		van.dock_all_fixed_bikes_from(garage)
	end

end