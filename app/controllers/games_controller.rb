class GamesController < ApplicationController
  
  before_action :authenticate_user!
  
  def new
    @game = Game.new
  end

  def create
    @game = current_user.games.new(game_params)
    @game.save
    puts @game.errors.full_messages 
    redirect_to game_path(@game)
  end

  def show
    @game = Game.find(params[:id])
  end

  def index
    @games = Game.all
  end

  def update
  end

  private

  def game_params
    params.require(:game).permit(:name, :white_id, :black_id, :username)
  end
end
