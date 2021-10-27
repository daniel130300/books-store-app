class UsersController < ApplicationController
  
    rescue_from Exceptions::BaseException, :with => :render_error_response
    
    def search_friend
    end
  
    def serve_search_friend
      raise Exceptions::ApiExceptions::FriendError::MissingSearchTerms if params[:friend].blank?
      @friends = User.search(params[:friend], current_user)
      if !@friends.blank?
        @friends.each { |friend| friend.already_friends = current_user.not_friends_with?(friend.id) }
      end
      respond_to do |format|
        format.js { render partial: 'users/partials/friend_result' }
      end
    end

    def my_friends
      @friends = current_user.friends
    end

    def show
      @to_friend_checkout = ShoppingCart.new()
      @user = User.find(params[:id])
      @user.already_friends = current_user.not_friends_with?(@user.id)
      @owned_books = Book.joins(sale_books: :sale).where(sales: {user_id: @user.id, friend_id: nil }).distinct.paginate(page: params[:page], per_page: 5)
      @wishlist_books = @user.wish_books.paginate(page: params[:page], per_page: 5)
      if !@wishlist_books.blank?
        @wishlist_books.each do |book| 
          book.wish_book_owner = false
          book.price_details = Services::GetCartPrices.call(book)
        end
      end
    end

    def my_books
      @owned_books = Book.joins(sale_books: :sale).where(sales: {user_id: current_user.id, friend_id: nil }).distinct.paginate(page: params[:page], per_page: 5)
    end

    def my_wishlist
      @wishlist_books = current_user.wish_books.paginate(page: params[:page], per_page: 5)
      if !@wishlist_books.blank?
        @wishlist_books.each { |book| book.wish_book_owner = true }
      end
    end

    private

    def render_error_response(error)
      @error = error 
      respond_to do |format|
        format.js { render partial: 'shared/ajax_error' }
      end
    end
end
  