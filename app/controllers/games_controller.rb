class GamesController < ApplicationController
  
  before_action :authenticate_user!
  
  def new
    @game = Game.new
  end

  def create
    @game = Game.create(game_params)
    redirect_to game_path(@game)
  end

  def show
  end

  def index
    redirect_to #path ??
  end

  def update
  end

  private

  def game_params
    params.require(:game).permit(:name, :white_id, :black_id)
  end

