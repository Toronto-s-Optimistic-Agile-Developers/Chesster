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
  
   def forfeit
    @game = Game.find_by_id(params[:id])
    if current_user.id == @game.white_id
      @game.update_attributes(winner: @game.black_id, loser: @game.white_id)
    else
      @game.update_attributes(winner: @game.white_id, loser: @game.black_id)
    end
    redirect_to games_path
  end

  def destroy
    @game = Game.find_by_id(params[:id])
    if @game.in_play?
      return render plain: "Not Allowed", status: :forbidden
    else
      @game.pieces.destroy_all
      @game.destroy
      redirect_to games_path
    end
  end

  private

  def game_params
    params.require(:game).permit(:name, :white_id, :black_id, :winner, :loser)
  end
end
