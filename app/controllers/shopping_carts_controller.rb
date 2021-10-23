class ShoppingCartsController < ApplicationController

    def index
        @cart_checkout = ShoppingCart.new()
        @cart_books = current_user.shopping_carts
        @prices = Services::GetCartPrices.call(@cart_books)
    end

    def update_cart_prices
        book = current_user.shopping_carts.where(search_cart_params)
        if book.update(update_cart_params)
            @prices = Services::GetCartPrices.call(current_user.shopping_carts)
        end
    end

    def create
        current_user.shopping_carts.build(cart_params)
        if current_user.save
            flash[:notice] = "Book added to shopping cart"
        else
            flash[:alert] = "There was something wrong adding this book to your shopping cart"
        end
        redirect_to book_path(params[:book][:book_id])
    end
  
    def destroy
        book = current_user.wishlists.where(cart_params).first
        if book.destroy
            flash[:notice] = "Book removed from your shopping cart"
            redirect_to book_path(params[:id])
        else 
            flash[:alert] = "There was something wrong adding this book to your shopping cart"
        end

        redirect_to my_friends_path
    end

    private

    def cart_params 
        params.require(:book).permit(:book_id, :quantity, :price)
    end

    def update_cart_params 
        params.require(:shopping_cart).permit(:book_id, :quantity)
    end

    def search_cart_params 
        params.require(:shopping_cart).permit(:book_id)
    end
end