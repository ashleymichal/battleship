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

  # @param [Ship] ship
  # @param [Array] position list of sequential cells
  def place_ship(ship, position)
    position.map { |cell| cell[:contents] = ship.id }
  end

  # Changes board to update status of cell and hit count of ship contained in cell
  # Raises AlreadyHitError if cell has already been fired upon
  #
  # @param [Integer] x row index
  # @param [Integer] y column index
  def fire!(x, y)
    cell = get_cell(x, y)
    raise AlreadyHitError unless cell[:status] == :blank
    cell[:contents] ? hit!(cell) : miss!(cell)
  end

  # Retrieves a 'cell' Hash from within the board attribute
  #
  # @param [Integer] x row index
  # @param [Integer] y column index
  #
  # @return [Hash<Symbol, Symbol>] cell hash with :status and :contents
  def get_cell(x, y)
    board[x][y]
  end

  # @param [Fixnum] size
  #
  # @return [Array<Hash>] of random sequence of cells (row/columnwise)
  def random_position(size)
    viable_positions(size).sample
  end

  # @param [Fixnum] size
  #
  # @return [Array] of all possible sequences of 'size' length
  def viable_positions(size)
    all_lines.flat_map { |line| empty_runs(line, size) }
  end

  private

  def randomly_place_ships
    default_ships.each do |ship|
      place_ship(ship, random_position(ship.size))
    end
  end

  def default_board
    Array.new(ROWS) { Array.new(COLUMNS) { { contents: nil, status: :blank } } }
  end

  # @return [Array<Ship>] standard fleet for start of game
  def default_ships
    Ship::SHIP_SIZES.inject([]) do |fleet, (type, size)|
      SHIP_COUNTS[type].times { fleet << Ship.build(type) }
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

  def hit!(cell)
    cell[:status] = :hit
    ship = Ship.find(cell[:contents])
    ship.hit!
    self.save
  end

  def miss!(cell)
    cell[:status] = :miss
    Game.decrement_counter(:shots_remaining, self.id)
    self.save
  end

end