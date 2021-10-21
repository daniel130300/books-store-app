class UsersController < ApplicationController

    rescue_from Exceptions::BaseException, :with => :render_error_response
    
    def search_friend
    end
  
    def serve_search_friend
      raise Exceptions::ApiExceptions::FriendError::MissingSearchTerms if params[:friend].blank?
      @friends = User.search_friend(params[:friend]).where.not(id: current_user.id)
      p @friends
      if !@friends.blank?
        @friends.each { |friend| friend.already_friends = current_user.not_friends_with?(friend.id)}
      end
      respond_to do |format|
        format.js { render partial: 'users/partials/friend_result' }
      end
    end

    def my_friends
      @friends = current_user.friends
    end

    def show
      @user = User.find(params[:id])
      @user.already_friends = current_user.not_friends_with?(@user.id)
      if !@user.wish_books.blank?
        @user.wish_books.each { |book| book.wish_book_owner = Wishlist.is_book_owner?(book, current_user) }
      end
    end

    def my_wishlist
      if !current_user.wish_books.blank?
        current_user.wish_books.each { |book| book.wish_book_owner = Wishlist.is_book_owner?(book, current_user) }
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
  