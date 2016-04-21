class GamesController < ApplicationController

  def new
  end

  def create
    @game = Game.create
    redirect_to @game
  end

  def show
    @game = Game.find(params[:id])
  end

  def fire
    game = Game.find(params[:id])
    x = params[:x].to_i
    y = params[:y].to_i
    game.fire!(x, y)
    render json: { status: game.get_cell(x, y)[:status] }
  end

end
