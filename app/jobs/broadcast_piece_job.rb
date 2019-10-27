class BroadcastPieceJob < ApplicationJob
  queue_as :default

  def perform(data)
    ActionCable.server.broadcast "piece_#{data[:x_coord, :y_coord]}", data
  end
end
