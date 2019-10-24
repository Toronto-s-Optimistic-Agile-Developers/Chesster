App.pieces = App.cable.subscriptions.create "PiecesChannel",
  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    # Called when there's incoming data on the websocket for this channel

  move: ->
    @perform 'pieces', x_coord: x_coord, y_coord: y_coord
