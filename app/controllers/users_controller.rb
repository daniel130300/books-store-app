class UsersController < ApplicationController

    rescue_from Exceptions::BaseException, :with => :render_error_response
    
    def friends
      @friends = current_user.friends
    end
  
    def show
      @user = User.find(params[:id])
      @user.already_friends = current_user.not_friends_with?(@user.id)
    end
  
    def search
      @friends = User.search(current_user.id, params[:friend]) 
      if !@friends.blank?
        @friends.each { |friend| friend.already_friends = current_user.not_friends_with?(friend.id)}
      end
      respond_to do |format|
        format.js { render partial: 'users/friend_result' }
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
  