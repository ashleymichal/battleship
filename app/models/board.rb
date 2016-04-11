class Board
  attr_accessor :grid
  def initialize
    @grid = default_grid
  end

  private

  def default_grid
    Array.new(10) { Array.new(10) { Cell.new } }
  end

end