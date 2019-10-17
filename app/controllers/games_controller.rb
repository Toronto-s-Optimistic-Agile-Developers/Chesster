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

  def left_white_castle
    king_white = @game.pieces.find_by(x_coord: 4, y_coord: 0)
    left_rook = @game.pieces.find_by(x_coord: 0, y_coord: 0)
    if (king_white.initial_position? == true && left_rook.initial_position? == true)
      king_white.update(x_coord: 0, initial_position?: false)
      left_rook.update(x_coord: 4, initial_position?: false)
    elsif
      flash[:alert] = 'You cannot castle this way!'
    end
  end

  def right_white_castle
    king_white = @game.pieces.find_by(x_coord: 4, y_coord: 0)
    right_rook = Piece.find_by(x_coord: 7, y_coord: 0)
    if (king_white.initial_position? == true && left_rook.initial_position? == true)
      king_white.update(x_coord: 0, initial_position?: false)
      right_rook.update(x_coord: 4, initial_position?: false)
    elsif
      flash[:alert] = 'You cannot castle this way!'
    end
  end

  def left_black_castle
    king_black = @game.pieces.find_by(x_coord: 4, y_coord: 7)
    left_rook = @game.pieces.find_by(x_coord: 0, y_coord: 7)
    if (king_white.initial_position? == true && left_rook.initial_position? == true)
      king_black.update(x_coord: 0, initial_position?: false)
      left_rook.update(x_coord: 4, initial_position?: false)
    elsif
      flash[:alert] = 'You cannot castle this way!'
    end
  end

  def right_black_castle
    king_black = @game.pieces.find_by(x_coord: 4, y_coord: 7)
    right_rook = Piece.find_by(x_coord: 7, y_coord: 7)
    if (king_black.initial_position? == true && left_rook.initial_position? == true)
      king_black.update(x_coord: 0, initial_position?: false)
      right_rook.update(x_coord: 4, initial_position?: false)
    elsif
      flash[:alert] = 'You cannot castle this way!'
    end
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
