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
        format.js { render partial: 'users/friend_result' }
      end
    end

    def my_friends
      @friends = current_user.friends
    end

    def show
      @user = User.find(params[:id])
      @user.already_friends = current_user.not_friends_with?(@user.id)
    end

    def my_wishlist
    end

    private

    def render_error_response(error)
      @error = error 
      respond_to do |format|
        format.js { render partial: 'shared/ajax_error' }
      end
    end
end
  