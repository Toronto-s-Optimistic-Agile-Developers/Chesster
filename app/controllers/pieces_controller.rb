class PiecesController < ApplicationController
  before_action :find_piece, only: [:update, :show]

  
  def create
    @piece = game.pieces.create(piece_params)
    if @piece.valid?
      redirect_to games_path(@game)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @piece = Piece.find(params[:id])
  end

  def update
    x_path = piece_params[:x_coord].to_i
    y_path = piece_params[:y_coord].to_i
    new_rank =  piece_params[:promotion_type].to_s
    if @piece.game.in_play? == false
      flash[:alert] = 'There must be two players before you can begin.'
      @game.reload
    elsif ! (user_colors == @piece.color && @piece.game.turn_user_validation == @piece.color)
      flash[:alert] = 'You can only move a piece that belongs, and you can only do so when it is your turn.'
      @game.reload
    elsif @piece.name == "Black_King"  && ((@piece.x_coord == 0) || (@piece.x_coord == 7)) && (@piece.y_coord == 0)
      @piece.castle(x_path, y_path)
    elsif @piece.name == "White_King" && ((@piece.x_coord == 0) || (@piece.x_coord == 7)) && (@piece.y_coord == 7)
      @piece.castle(x_path, y_path)
    elsif @piece.promotion? == true
      @piece.update(piece_params)
      @piece.pawn_promote(new_rank)
      redirect_to @game
      flash[:notice] = 'You have successfully promoted your pawn! Please refresh the page to complete the transformation.'
      @game.reload
    elsif piece = @piece.name == "Black_King" && ! @piece.legal_move?(x_path, y_path)
      if @piece.black_right_castle(x_path, y_path) == true 
        @piece.black_right_castle(x_path, y_path)
        @game.reload
        flash[:notice] = 'You have successfully completed Castling.'
      elsif @piece.black_left(x_path, y_path) 
        @piece.black_left_castle(x_path, y_path)
        @game.reload
        flash[:notice] = 'You have successfully completed Castling.'
      end
    elsif @piece.name == "White_King" && ! @piece.legal_move?(x_path, y_path)
      if @piece.white_right_castle(x_path, y_path) == true 
        @piece.white_right_castle(x_path, y_path)
        @game.reload
        flash[:notice] = 'You have successfully completed Castling.'
      elsif @piece.white_left(x_path, y_path) == true
        @game.reload
     end    
     elsif (user_colors == @piece.color && @piece.game.turn_user_validation == @piece.color)  
      @piece.valid_move?(x_path, y_path)
      @piece.move_to!(x_path, y_path)
      @piece.update(initial_position?: false)
      @piece.update_attributes(piece_params)
      respond_to do |format|
        format.html { render :show }
        format.json { render json: @piece, status: :ok }
      end
      @game.reload
      flash[:notice] = 'Your move was successfully completed!' 
    end
    @game.reload
  end

  def show
    @game = @piece.game
    @pieces = @game.pieces  
  end

  private

  def user_colors 
    @gameplayer = @piece.game.player_id.to_i
    @gameplayer2 = @piece.game.second_player_id.to_i
    if (current_user.id == @gameplayer) 
      return 'white'
    else
      return 'black'
    end
  end

  def find_piece
    @piece = Piece.find(params[:id])
    @game = @piece.game
  end

  def piece_params
    params.require(:piece).permit(:id, :name, :color, :x_coord, :y_coord, :game_id, :player_id, :captured, :initial_position?, :promotion?, :promotion_type, :title)
  end
end
