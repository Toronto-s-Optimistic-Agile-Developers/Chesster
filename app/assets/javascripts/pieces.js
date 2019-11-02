$(document).ready(function () {
  $('[data-toggle="capture-instructions"]').tooltip();
});
var rotation = 0;
jQuery.fn.rotate = function (degrees) {
  $(this).css({
    '-webkit-transform': 'rotate(' + degrees + 'deg)',
    '-moz-transform': 'rotate(' + degrees + 'deg)',
    '-ms-transform': 'rotate(' + degrees + 'deg)',
    'transform': 'rotate(' + degrees + 'deg)'
  });
};
$('#Flip_Board').click(function () {
  rotation -= 180;
  $('.set-board, .chess td, #labels td').rotate(rotation);
});
$(document).ready(function () {
  $('.piece').draggable({
    snap: '.droppable-tile',
    revert: 'invalid'
  });
  $('.droppable-tile').droppable({
    drop: function (event, ui) {
      var piece = ui.draggable
      var destination_square = $(this);
      console.log($(this))
      c = $(this)
      var update_piece = {
        id: piece.data('piece-id'),
        x_coord: destination_square.data('x-coord'),
        y_coord: destination_square.data('y-coord'),
        name: destination_square.data('name'),
      }
      $.ajax({
        type: 'PATCH',
        url: '/pieces/' + update_piece.id,
        beforeSend: function (xhr) {
          xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))
        },
        dataType: 'json',
        data: {
          piece: {
            id: update_piece.id,
            x_coord: update_piece.x_coord,
            y_coord: update_piece.y_coord,
            name: update_piece.name
          }
        },
        success: function (data) {
          destination_square.empty();
          location.reload(true);
        }
      });
    }
  });
});