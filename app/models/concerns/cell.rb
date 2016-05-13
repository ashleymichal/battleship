class Cell
  attr_accessor :status, :contents

  def initialize(input = {})
    @status = input[status] || :blank
    @contents = input[contents]
  end

  def fire!
    raise AlreadyHitError, "Already Fired" unless @status == :blank
    @contents ? hit! : miss!
    @status
  end

  protected

  def hit!
    ship = Ship.find(@contents)
    ship.hit!
    @status = :hit
  end

  def miss!
    @status = :miss
  end

end