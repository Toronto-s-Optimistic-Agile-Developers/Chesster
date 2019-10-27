App.pieces = App.cable.subscriptions.create("PiecesChannel", {
  connected: function() {
    console.log("Connected to the Pieces channel")
  },
  disconnected: function() {
    console.log("Disconnected to the Pieces channel")
  },
  received: function(data) {
    var playPiece = $('.piece')
    playPiece.append(data[piece])
  }
});
