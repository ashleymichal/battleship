class Ship < ActiveRecord::Base

  CARRIER_TYPE = 'carrier'
  VESSEL_TYPE = 'vessel'
  BOAT_TYPE = 'boat'

  SHIP_SIZES = { CARRIER_TYPE => 5, VESSEL_TYPE => 3, BOAT_TYPE => 1 }

end
