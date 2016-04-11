class Game < ActiveRecord::Base
  SHIP_COUNTS = { Ship::CARRIER_TYPE => 2,
                  Ship::VESSEL_TYPE  => 3,
                  Ship::BOAT_TYPE    => 5 }
  ROWS = 10
  COLUMNS = 10
  serialize :board
  before_create :set_game_board

  # Sets up new board with randomly placed ships
  def set_game_board
    self.board = default_board
    randomly_place_ships
  end

  # @param ship [Ship]
  # @param position [Array] list of sequential cells
  def place_ship(ship, position)
    position.map { |cell| cell[:contents] = ship }
  end

  # @param size [Fixnum]
  #
  # @return [Array<Hash>] of random sequence of cells (row/columnwise)
  def random_position(size)
    viable_positions(size).sample
  end

  # @param size [Fixnum]
  #
  # @return [Array] of all possible sequences of 'size' length
  def viable_positions(size)
    all_lines.flat_map { |line| empty_runs(line, size) }
  end

  private

  def randomly_place_ships
    default_ships.each do |ship|
      place_ship(ship, random_position(Ship::SHIP_SIZES[ship.ship_type]))
    end
  end

  def default_board
    Array.new(ROWS) { Array.new(COLUMNS) { { contents: nil, hit: false } } }
  end

  # @return [Array<Ship>] standard fleet for start of game
  def default_ships
    Ship::SHIP_SIZES.inject([]) do |fleet, (type, size)|
      SHIP_COUNTS[type].times { fleet << Ship.create(ship_type: type) }
      fleet
    end
  end

  def empty_runs(line, size)
    line.each_cons(size).select { |run| run.none? { |cell| cell[:contents] } }
  end

  def all_lines
    rows + columns
  end

  def rows
    board
  end

  def columns
    board.transpose
  end

end