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
    @game = Game.find(params[:id])
    begin
      @game.fire!(params[:x].to_i, params[:y].to_i)
    rescue AlreadyHitError
      flash[:errors] = "You already fired on that cell!"
    end
    redirect_to @game
  end

end
