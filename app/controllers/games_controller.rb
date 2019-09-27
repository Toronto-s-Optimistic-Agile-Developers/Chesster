class GamesController < ApplicationController
  
  before_action :authenticate_user!
  
  def new
    @game = Game.new
  end

  def create
    @game = current_user.games.create(white_id: current_user.id, name: game_params["name"])
    @game.save
    @game.set_up_board!
    redirect_to game_path(@game)
  end

  def show
    @game = Game.find_by_id(params[:id])
    @pieces = @game.pieces
  end

  def index
    @unmatched_games = Game.where(:white_id => nil).where.not(:black_id => nil).or (Game.where.not(:white_id => nil).where(:black_id => nil))
  end

  def join
    @game = Game.find_by_id(params[:id])
    @game.update(black_id: current_user.id)
    redirect_to game_path(@game)
  end

  def update
    @game = current_game
    @game.update(game_params)
    @game.reload
  end

  private

  def game_params
    params.require(:game).permit(:name, :white_id, :black_id)
  end
end
