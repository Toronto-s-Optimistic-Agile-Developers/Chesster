class GamesController < ApplicationController
  
  before_action :authenticate_user!
  
  def new
    @game = Game.new
  end

  def create
    @game = current_user.games.create(game_params)
    @game.set_up_board!
    redirect_to game_path(@game)
  end

  def show
    @game = Game.find_by_id(params[:id])
    @piece = Piece.all
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
