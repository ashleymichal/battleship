class GamesController < ApplicationController

  def create
    @game = Game.create
    render json: @game, root: false
  end

  def show
    @game = Game.find(params[:id])
    render json: @game, root: false
  rescue
    render json: { error: $!.message }
  end

  def fire
    @game = Game.find(params[:id])
    x = params[:x].to_i
    y = params[:y].to_i
    render json: { status: @game.fire!(x, y) }
  rescue
    render json: { error: $!.message }
  end

end
