require 'rails_helper'

RSpec.describe GamesController, type: :controller do
  let(:game) { Game.create }

  describe "GET new" do

    it "renders the new view" do
      get :new
      expect(response).to render_template :new
    end

  end

  describe "POST create" do

    it "creates a Game" do
      expect { post :create }.to change(Game, :count).by(1)
    end

    it "redirects to show action" do
      post :create
      expect(response).to redirect_to Game.last
    end

  end

  describe "GET show" do
    before do
      get :show, id: game.id
    end

    it "assigns a game variable" do
      expect(assigns(:game)).to eql(game)
    end

    it "renders the show view" do
      expect(response).to render_template :show
    end

  end

  describe "PATCH fire" do

    context "when cell status is :blank" do
      it "changes the board to reflect the hit" do
        expect{ patch :fire, id: game.id, x: 0, y: 0 }.to change{ Game.find(game.id).board }
      end
    end

  end

end
