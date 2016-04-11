class Cell
  attr_accessor :ship, :status
  def initialize
    @ship = nil
    @status = :blank
  end

  def hit!
    raise AlreadyHitError unless status == :blank
    @status = ship ? :hit : :miss
  end

end