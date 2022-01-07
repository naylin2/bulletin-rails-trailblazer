$(document).on('turbolinks:load', function() {
    $('#table_id').DataTable({
      "searching": false,
      "bLengthChange": false,
      "info": false,
    });
} )
$("#postDetail").find(".modal-content").html("<%= j (render 'show') %>");
$("#postDetail").modal('show');