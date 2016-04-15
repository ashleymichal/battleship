require 'rails_helper'

RSpec.describe Ship, type: :model do
  let(:carrier) { Ship.build(Ship::CARRIER_TYPE) }

  describe "#sunk?" do

    it "returns true if ship has been hit 'size' times" do
      carrier.hits = 5
      expect(carrier.sunk?).to be true
    end

    it "returns false if ship has been hit less than 'size' times" do
      carrier.hits = 1
      expect(carrier.sunk?).to be false
    end

  end

  describe "#hit!" do
    it "increments 'hit' attribute by 1" do
      expect{
        carrier.hit!

        carrier.reload
      }.to change{ carrier.hits }.by(1)
    end
  end

end
