class GamesController < ApplicationController
  before_filter :find_game, only:[:show, :join]
  before_filter :require_signin

  def show
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

  def join
    @game.participant=current_user.id
    @game.status="active"
    @game.whose_turn=current_user.id
    @game.save
    redirect_to @game
  end

  private

  def find_game
    @game = Game.find(params[:id])
  end

end
