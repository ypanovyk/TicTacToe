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
    if signed_in?
      @games = Game.find(:all)
    else
      redirect_to signin_path
    end
  end

  def join
    @game = Game.find(params[:id])
    @game.participant=current_user.id
    @game.status="active"
    @game.save
    redirect_to @game
  end
end
