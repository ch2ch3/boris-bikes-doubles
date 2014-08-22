require 'metadata'

class Thing; include Metadata; end

describe Thing do

	let(:thing) { Thing.new }

	it "has a serial number" do
		expect(thing.serial_number).to match(/^[A-Z]{3}-\d{5}$/)
	end

	it "has a unique serial number" do
		expect(thing.serial_number).not_to eq Thing.new.serial_number
	end

end