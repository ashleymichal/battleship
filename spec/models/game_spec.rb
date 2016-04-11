require 'rails_helper'

RSpec.describe Game, type: :model do
  subject { Game.create }
  let(:board) { subject.board }

  describe "#set_game_board" do

    it "initializes a 100 cells by default" do
      expect(board.flatten.size).to eql 100
    end

  end

end
