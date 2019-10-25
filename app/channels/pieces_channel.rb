class PiecesChannel < ApplicationCable::Channel
  def subscribed
    stream_from "pieces"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def pieces(data)
    piece = @piece.where(x_coord: x_path, y_coord: y_path).first
    @perform
  end
end
