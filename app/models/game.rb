class Game < ActiveRecord::Base
  ROWS = 10
  COLUMNS = 10
  serialize :board
  before_create :set_game_board

  private

  def set_game_board
    self.board = default_board
  end

  # Instantiates board with 100 unhit cells
  #
  # @return nested [Array] of rows of empty game board cells
  def default_board
    Array.new(ROWS) { Array.new(COLUMNS) { { contents: nil, hit: false } } }
  end

  def rows
    board
  end

  def columns
    board.transpose
  end

end