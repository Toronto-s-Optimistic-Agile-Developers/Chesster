class GamesController < ApplicationController
  
  before_action :authenticate_user!, only: [:create, :new]
  
  def new
    @game = Game.new
  end

  def create
    @game = Game.create(game_params)
    game.white_id = current_user
    game.save
    redirect_to game_path(@game)
  end

  def show
  end

  def index
    @game = Game.available
  end

  def join
    @game = Game.find(params[:id])
    if @game.available?
      @game.black_id = current_user
      @game.save
      redirect_to game_path(@game)
    else :text, :status => :unprocessable_entity
      redirect_to games_path


  end

  private

  def game_params
    params.require(:game).permit(:name, :game_id, :white_id, :black_id)
  end
end