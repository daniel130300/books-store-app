class ShoppingCartsController < ApplicationController

    def index
        @cart_checkout = ShoppingCart.new()
        @cart_books = current_user.shopping_carts.includes(:book)
        @prices = Services::GetCartPrices.call(@cart_books)
    end

    def update_cart_prices
        book = current_user.shopping_carts.where(search_cart_params)
        if book.update(update_cart_params)
            @prices = Services::GetCartPrices.call(current_user.shopping_carts)
        end
        redirect_to shopping_carts_path
    end

    def create
        current_user.shopping_carts.build(create_cart_params)
        if current_user.save
            flash[:notice] = "Book added to shopping cart"
        else
            flash[:alert] = "There was something wrong adding this book to your shopping cart"
        end
        redirect_to book_path(params[:book][:book_id])
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