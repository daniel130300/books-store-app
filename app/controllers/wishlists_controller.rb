class WishlistsController < ApplicationController

    def create
        current_user.wishlists.build(book_id: params[:book])
        if current_user.save
            flash[:notice] = "Book added to wishlist"
        else
            flash[:alert] = "There was something wrong adding this book to your wishlist"
        end
        redirect_to book_path(params[:book])
    end
  
    def destroy
        book = current_user.wishlists.where(book_id: params[:id]).first
        if book.destroy
            flash[:notice] = "Book removed from wishlist"
        else 
            flash[:alert] = "There was something wrong adding this book to your wishlist"
        end
        
        redirect_to my_wishlist_path
    end
end