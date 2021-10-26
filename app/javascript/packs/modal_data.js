$(document).on('turbolinks:load' ,function() {
    $('#buyBookModal').on('show.bs.modal', function (event) {
        var button = $(event.relatedTarget);
        var book = button.data('whatever');
        var modal = $(this);
        body = $('.modal-body');
        body.prepend("<p class='text-center font-weight-bold'>"+book["title"]+"</p>");
        body.prepend("<img src="+book["image_link"]+" alt="+book["title"]+" class='text-center rounded mx-auto d-block my-2' />");
    })

    $('#buyBookModal').on('hide.bs.modal', function (event) {
        body = $('.modal-body');
        body.empty();
    })
});
    