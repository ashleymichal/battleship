require 'rails_helper'

RSpec.describe Game, type: :model do
  subject { Game.create }
  let(:board) { subject.board }
  let(:all_cells) { board.flatten }

  describe "#set_game_board" do
    let(:cells_with_ships) { all_cells.select { |cell| cell[:contents] } }

    it "initializes a 100 cells by default" do
      expect(all_cells.size).to eql 100
    end

    it "places 10 ships on the board" do
      expect(cells_with_ships.uniq).to have(10).things
    end

    it "places 2 carriers" do
      carriers = cells_with_ships.select do |cell|
        Ship.find(cell[:contents]).ship_type == Ship::CARRIER_TYPE
      end
      expect(carriers.uniq.size).to eql(Game::SHIP_COUNTS[Ship::CARRIER_TYPE])
    end

    it "places 3 vessels" do
      vessels = cells_with_ships.select do |cell|
        Ship.find(cell[:contents]).ship_type == Ship::VESSEL_TYPE
      end
      expect(vessels.uniq.size).to eql(Game::SHIP_COUNTS[Ship::VESSEL_TYPE])
    end

    it "places 5 boats" do
      boats = cells_with_ships.select do |cell|
        Ship.find(cell[:contents]).ship_type == Ship::BOAT_TYPE
      end
      expect(boats.uniq.size).to eql(Game::SHIP_COUNTS[Ship::BOAT_TYPE])
    end

  end

  describe "#place_ship" do
    let(:position) { [board[0][0], board[0][1], board[0][2]] }
    let(:ship) { Ship.build(Ship::BOAT_TYPE) }

    context "an individual ship" do

      it "changes each position's 'contents' to 'ship'" do
        subject.send(:place_ship, ship, position)
        expect(position).to be_all { |cell| Ship.find(cell[:contents]) == ship }
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

  describe "#fire!" do
    let(:cell) { subject.get_cell(0, 0) }

    context "cell has not been fired upon" do

      context "cell is occupied" do
        before do
          cell[:contents] ||= Ship.build(Ship::BOAT_TYPE).id
          subject.fire!(0, 0)
        end
        it "changes the cell's status to :hit" do
          expect(cell[:status]).to eql(:hit)
        end

        it "hits the ship object" do
          expect(Ship.find(cell[:contents]).hits).to eql(1)
        end

        it "does not decrement number of 'shots_remaining'" do
          expect(subject.shots_remaining).to eql(50)
        end
      end

      context "cell is unoccupied" do
        before do
          cell[:contents] = nil
          subject.fire!(0, 0)
        end
        it "changes the cell's status to :miss" do
          expect(cell[:status]).to eql(:miss)
        end

        it "decrements the number of 'shots_remaining'" do
          subject.reload
          expect(subject.shots_remaining).to eql(49)
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
