require 'rails_helper'

RSpec.describe Game, type: :model do
  subject { Game.create }
  let(:board) { subject.board }
  let(:all_cells) { board.flatten }
  let(:all_cell_contents) { all_cells.map { |cell| cell.contents } }

  describe "#set_game_board" do

    it "initializes 100 cells by default" do
      expect(all_cells.size).to eql 100
    end

  end

  describe "#randomly_place_ships" do
    let(:ships_on_board) { all_cell_contents.compact }
    before do
      subject.randomly_place_ships
    end

    it "places 10 ships on the board" do
      expect(ships_on_board.uniq).to have(10).things
    end

    it "places 2 carriers" do
      carriers = ships_on_board.select do |ship|
        Ship.find(ship).ship_type == Ship::CARRIER_TYPE
      end
      expect(carriers.uniq.size).to eql(Game::SHIP_COUNTS[Ship::CARRIER_TYPE])
    end

    it "places 3 vessels" do
      vessels = ships_on_board.select do |ship|
        Ship.find(ship).ship_type == Ship::VESSEL_TYPE
      end
      expect(vessels.uniq.size).to eql(Game::SHIP_COUNTS[Ship::VESSEL_TYPE])
    end

    it "places 5 boats" do
      boats = ships_on_board.select do |ship|
        Ship.find(ship).ship_type == Ship::BOAT_TYPE
      end
      expect(boats.uniq.size).to eql(Game::SHIP_COUNTS[Ship::BOAT_TYPE])
    end

  end

  describe "#place_ship" do
    let(:position) { [board[0][0], board[0][1], board[0][2]] }
    let(:ship) { Ship.build(Ship::BOAT_TYPE) }

    context "an individual ship" do

      it "changes each position's 'contents' to 'ship'" do
        subject.place_ship(ship, position)
        expect(position).to be_all { |cell| Ship.find(cell.contents) == ship }
      end

    end

  end

  describe "#viable_positions" do
    let(:viable_positions)  { subject.viable_positions(5) }
    let(:occupied_position) { board[0][0].contents = :ship }

    it "does not run off the board" do
      expect(viable_positions.flatten.all? do |postion|
        all_cells.include?(postion)
      end).to be true
    end

    it "does not select cells that are occupied" do
      expect(viable_positions.flatten.include?(occupied_position)).to be false
    end

  end

  describe "#get_cell" do
    it "returns the proper Cell object" do
      expect(subject.get_cell(0, 0)).to be_instance_of(Cell)
    end

    it "raises an error if it gets invalid coordinates" do
      expect{ subject.get_cell(0, 10) }.to raise_error(InvalidCoordinatesError)
      expect{ subject.get_cell(10, 0) }.to raise_error(InvalidCoordinatesError)
    end
  end

  describe "#fire!" do
    let(:cell) { subject.get_cell(0, 0) }

    context "cell has not been fired upon" do

      context "cell is occupied" do
        before do
          cell.contents ||= Ship.build(Ship::BOAT_TYPE).id
          subject.fire!(0, 0)
        end

        it "does not decrement number of 'shots_remaining'" do
          expect(subject.shots_remaining).to eql(50)
        end

        it "returns :hit status" do
          expect(cell.status).to be(:hit)
        end
      end

      context "cell is unoccupied" do
        before do
          cell.contents = nil
          subject.fire!(0, 0)
        end

        it "decrements the number of 'shots_remaining'" do
          subject.reload
          expect(subject.shots_remaining).to eql(49)
        end

        it "returns :miss status" do
          expect(cell.status).to be(:miss)
        end
      end

    end

    context "cell has already been fired upon" do
      it "raises an exception when cell has already been fired upon" do
        subject.fire!(0, 0)
        expect{ subject.fire!(0, 0) }.to raise_error(AlreadyHitError)
      end
    end

  end

end
