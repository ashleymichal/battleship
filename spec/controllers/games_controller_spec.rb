require 'rails_helper'

RSpec.describe GamesController, type: :controller do
  let(:game) { FactoryGirl.create(:game) }
  describe "POST create" do
    let(:json) { JSON.parse(response.body) }
    before do
      post :create
    end

    it "creates a Game" do
      expect { post :create }.to change(Game, :count).by(1)
    end

    it "returns an OK response code" do
      expect(response).to be_success
    end

    it "returns a JSON board with statuses only" do
      board = json['board'].flatten
      expect(board.none? { |cell| cell['content'] }).to be_truthy
    end

    it "returns the Game ID" do
      expect(json['id']).to eq(assigns(:game).id)
    end

  end

  describe "GET show" do
    let(:json) { JSON.parse(response.body) }

    context "game exists" do
      before do
        get :show, id: game.id
      end

      it "returns an OK response code" do
        expect(response).to be_success
      end

      it "returns a JSON board with statuses only" do
        board = json['board'].flatten
        expect(board.none? { |cell| cell['content'] }).to be_truthy
      end

      it "returns the Game ID" do
        expect(json['id']).to eq(game.id)
      end
    end

    context "game does not exist" do
      before do
        game.id += 1
        get :show, id: game.id
      end

      it "returns error message as JSON response body" do
        expect(json['error']).to match("This game does not exist")
      end
    end

  end

  describe "PATCH fire" do
    let(:json) { JSON.parse(response.body) }
    before do
      patch :fire, id: game.id, x: 0, y: 0
    end

    it "returns an OK response code" do
      expect(response.status).to eq(200)
    end

    context "cell has not been fired upon" do
      it "returns the updated cell status as JSON response body" do
        expect(json['status']).to eq("miss")
      end
    end

    context "cell has already been fired upon" do
      it "returns error message as JSON response body" do
        patch :fire, id: game.id, x: 0, y: 0
        expect(json['error']).to eq("Already Fired")
      end
    end

    context "Game does not exist" do
      it "returns error message as JSON response body" do
        game.id += 1
        patch :fire, id: game.id, x: 0, y: 0
        expect(json['error']).to match("This game does not exist")
      end
    end

  end

end
