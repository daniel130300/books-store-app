class ShoppingCartsController < ApplicationController

    def create
        current_user.shopping_carts.build(user_id: current_user, book_id: params[:book])
        if current_user.save
            flash[:notice] = "Book added to shopping cart"
        else
            flash[:alert] = "There was something wrong adding this book to your shopping cart"
        end
        redirect_to book_path(params[:book])
    end
  
    def destroy
        book = current_user.wishlists.where(user_id: current_user, book_id: params[:id]).first
        if book.destroy
            flash[:notice] = "Book removed from your shopping cart"
            redirect_to book_path(params[:id])
        else 
            flash[:alert] = "There was something wrong adding this book to your shopping cart"
        end

        redirect_to my_friends_path
    end
end