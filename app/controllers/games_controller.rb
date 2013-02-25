class GamesController < ApplicationController

  def show
    @game = Game.find(params[:id])
  end

  def new
    @game = Game.new(creator: current_user.id, status:"new")
    #@game = Game.new(creator: current_user.id, status:new)
    @game.save
    redirect_to @game
  end

  def create
  end

  def index
    @games = Game.find(:all)
  end
end
