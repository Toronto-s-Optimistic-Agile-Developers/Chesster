class PieceBroadcastJob < ApplicationJob
  queue_as :default

  def perform(piece)    
    ActionCable.server.broadcast 'pieces', {
     piece: render_piece(piece)
     Pieces_controller.render(
       @piece
     )

    }
  end
  end

