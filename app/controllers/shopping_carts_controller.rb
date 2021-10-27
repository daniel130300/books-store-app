class ShoppingCartsController < ApplicationController

    def index
        @cart_checkout = ShoppingCart.new()
        @cart_books = current_user.shopping_carts.includes(:book).order(:book_id)
        @prices = Services::GetCartPrices.call(@cart_books)
    end

    def create
        if Book.check_book_availability(params[:book][:book_id], params[:book][:quantity])
            current_user.shopping_carts.build(create_cart_params)
            if current_user.save
                flash[:notice] = "Book added to shopping cart"
            else
                flash[:alert] = "There was something wrong adding this book to your shopping cart"
            end
        else
            flash[:alert] = "We're sorry, there are only #{Book.where(id: params[:book][:book_id]).first.quantity} units left"
        end
        redirect_to book_path(params[:book][:book_id])
    end

    def update_cart
        cart_book = current_user.shopping_carts.includes(:book).where('books.id = ?', params[:shopping_cart][:book_id]).references(:book).first
        if Book.check_book_availability(params[:shopping_cart][:book_id], params[:shopping_cart][:quantity])
            if cart_book.update(update_cart_params)
                @prices = Services::GetCartPrices.call(current_user.shopping_carts)
                flash[:notice] = "Book quantity updated in cart"
            else
                flash[:alert] = "Something went wrong trying to update the book's quantity"
            end
        else
            flash[:alert] = "We're sorry there are only #{cart_book.book.stock} units left for #{cart_book.book.title}"
        end

        redirect_to shopping_carts_path
    end
  
    def destroy
        book = current_user.shopping_carts.where(book_id: params[:id]).first
        if book.destroy
            flash[:notice] = "Book removed from your shopping cart"
        else 
            flash[:alert] = "There was something wrong deleting this book from your shopping cart"
        end

        redirect_to shopping_carts_path
    end

    def checkout 
        cart_books = current_user.shopping_carts.includes(:book).order(:book_id)
        transaction = Services::ProcessCartTransaction.new(current_user, cart_books)
        if transaction.call()
            CheckoutMailer.personal_checkout(current_user, transaction.sale, transaction.cart_items, Services::GetCartPrices.call(transaction.cart_items)).deliver_now
            flash[:notice] = "Successful transaction!"
            redirect_to books_path
        else
            error = transaction.error
            flash[:alert] = error
            redirect_to shopping_carts_path
        end 
    end

    def book_to_friend_checkout
        book = Book.where(id:params[:to_friend_checkout][:book_id]).first
        transaction = Services::ProcessCartTransaction.new(current_user, book, params[:to_friend_checkout][:friend_id])
        if transaction.call()
            p transaction.cart_items
            friend = User.where(id: params[:to_friend_checkout][:friend_id]).first
            CheckoutMailer.book_to_friend_checkout(current_user, friend, transaction.sale, transaction.cart_items, Services::GetCartPrices.call(transaction.cart_items)).deliver_now
            flash[:notice] = "Successful transaction!"
            redirect_to books_path
        else
            error = transaction.error
            flash[:alert] = error
            redirect_to user_path(params[:to_friend_checkout][:friend_id])
        end
    end

    private
    def create_cart_params 
        params.require(:book).permit(:book_id, :quantity, :price)
    end

    def update_cart_params 
        params.require(:shopping_cart).permit(:book_id, :quantity)
    end

    def search_cart_params 
        params.require(:shopping_cart).permit(:book_id)
    end
end