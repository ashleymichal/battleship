class Ship < ActiveRecord::Base

  CARRIER_TYPE = 'carrier'
  VESSEL_TYPE = 'vessel'
  BOAT_TYPE = 'boat'

  SHIP_SIZES = { CARRIER_TYPE => 5, VESSEL_TYPE => 3, BOAT_TYPE => 1 }

  # Factory for Carrier type Ship object
  #
  # @return [Ship]
  def self.build(type)
    create(ship_type: type)
  end

  # @return [Boolean]
  def sunk?
    hits == SHIP_SIZES[ship_type]
  end

  def hit!
    Ship.increment_counter(:hits, self.id)
  end

  def size
    SHIP_SIZES[self.ship_type]
  end

end
