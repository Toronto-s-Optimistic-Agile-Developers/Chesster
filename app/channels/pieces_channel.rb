class PiecesChannel < ApplicationCable::Channel
  def subscribed
    stream_from "games"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def pieces(data)
    piece = piece.find_by(x_coord: data[x_coord], x_coord: data[:y_coord])
  end
end
