module GamesHelper
  def cell_contents(cell)
    cell[:contents] || "empty"
  end
end