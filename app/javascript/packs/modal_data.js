$(document).on('turbolinks:load' ,function() {
    const formatToCurrency = amount => {
        return "$" + parseFloat(amount).toFixed(2).replace(/\d(?=(\d{3})+\.)/g, "$&,");
    };

    $('#buyBookModal').on('show.bs.modal', function (event) {
        var button = $(event.relatedTarget);
        [book, price_details, friend] = button.data('whatever');
        book = JSON.parse(book);
        price_details = JSON.parse(price_details);
        friend = JSON.parse(friend);
        var modal = $(this);
        body = $('.modal-body');
        body.append("<p class='text-center font-weight-bold'>"+book["title"]+"</p>");
        body.append("<img src="+book["image_link"]+" alt="+book["title"]+" class='text-center rounded mx-auto d-block my-2' />");
        body.append("<p><span class='text-center font-weight-bold'>Subtotal: </span>"+formatToCurrency(price_details["subtotal"])+"</p>");
        body.append("<p><span class='text-center font-weight-bold'>Taxes: </span>"+formatToCurrency(price_details["tax"])+"</p>");
        body.append("<p><span class='text-center font-weight-bold'>Total: </span>"+formatToCurrency(price_details["total"])+"</p>");
        form = $("#friend_checkout");
        $('<input>', {
            type: 'hidden',
            id: 'to_friend_checkout_friend_id',
            name: 'to_friend_checkout[friend_id]',
            value: friend['id']
        }).prependTo(form);
        $('<input>', {
            type: 'hidden',
            id: 'to_friend_checkout_book_price',
            name: 'to_friend_checkout[book_price]',
            value: book['sale_price']
        }).prependTo(form);
    });

    $('#buyBookModal').on('hide.bs.modal', function (event) {
        body = $('.modal-body');
        body.empty();
    });
});
    