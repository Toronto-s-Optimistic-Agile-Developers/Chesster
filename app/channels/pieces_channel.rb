class PiecesChannel < ApplicationCable::Channel
  def subscribed
    stream_from "pieces"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
