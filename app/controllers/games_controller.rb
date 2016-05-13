class GamesController < ApplicationController

  def create
    @game = Game.create
    @game.randomly_place_ships
    render json: @game, root: false
  end

  def show
    @game = Game.find(params[:id])
    render json: @game, root: false
  rescue ActiveRecord::RecordNotFound => game_not_found
    render json: { error: 'This game does not exist' }
  end

  def fire
    @game = Game.find(params[:id])
    x = params[:x].to_i
    y = params[:y].to_i
    render json: { status: @game.fire!(x, y) }
  rescue ActiveRecord::RecordNotFound => game_not_found
    render json: { error: 'This game does not exist' }
  rescue AlreadyHitError => already_hit
    render json: { error: already_hit.message }
  end

end
