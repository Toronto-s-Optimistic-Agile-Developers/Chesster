class PieceBroadcastJob < ApplicationJob
  queue_as :default

  def perform(piece)    
    ActionCable.server.broadcast "pieces", {
     piece: render_piece(piece)
    }
  end

  private

  def render_piece(piece)
    Pieces_controller.render(
    partial: 'piece',
    locals: { pieces:piece
    }
   )
  end

end

