require 'rails_helper'

RSpec.describe Game, type: :model do
  subject { Game.create }
  let(:board) { subject.board }
  let(:all_cells) { board.flatten }

  describe "#set_game_board" do

    it "initializes a 100 cells by default" do
      expect(all_cells.size).to eql 100
    end

    it "places 10 ships on the board" do
      cells_with_ships = all_cells.select { |cell| cell[:contents] }
      expect(cells_with_ships.uniq).to have(10).things
    end

    it "places 2 carriers" do
      carriers = all_cells.select { |cell| cell[:contents].try(:ship_type) == Ship::CARRIER_TYPE }
      expect(carriers.uniq.size).to eql(Game::SHIP_COUNTS[Ship::CARRIER_TYPE])
    end

    it "places 3 vessels" do
      vessels = all_cells.select { |cell| cell[:contents].try(:ship_type) == Ship::VESSEL_TYPE }
      expect(vessels.uniq.size).to eql(Game::SHIP_COUNTS[Ship::VESSEL_TYPE])
    end

    it "places 5 boats" do
      boats = all_cells.select { |cell| cell[:contents].try(:ship_type) == Ship::BOAT_TYPE }
      expect(boats.uniq.size).to eql(Game::SHIP_COUNTS[Ship::BOAT_TYPE])
    end

  end

  describe "#place_ship" do
    let(:position) { [board[0][0], board[0][1], board[0][2]] }
    let(:ship) { Ship.create(ship_type: Ship::BOAT_TYPE) }

    context "an individual ship" do

      it "changes each position's 'contents' to 'ship'" do
        subject.send(:place_ship, ship, position)
        expect(position).to be_all { |cell| cell[:contents] == ship }
      end

    end

  end

  describe "#viable_positions" do
    let(:viable_positions)  { subject.viable_positions(5) }
    let(:occupied_position) { board[0][0][:contents] = :ship }

    it "does not run off the board" do
      expect(viable_positions.flatten.all? { |p| all_cells.include?(p) }).to be true
    end

    it "does not select cells that are occupied" do
      expect(viable_positions.flatten.include?(occupied_position)).to be false
    end

  end

end
