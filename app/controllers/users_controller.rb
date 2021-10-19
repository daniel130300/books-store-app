class UsersController < ApplicationController
    def friends
      @friends = current_user.friends
    end
  
    def show
      @user = User.find(params[:id])
    end
  
    def search
      if params[:friend].present?
        @friends = User.search(current_user.id, params[:friend]) 
        if @friends.any? 
            respond_to do |format|
                format.js { render partial: 'users/friend_result' }
            end
        else
            flash.now[:alert] = "Couldn't found any user"
            respond_to do |format|
                format.js { render partial: 'users/friend_result' }
            end
        end
      else
        flash.now[:alert] = "Enter the name or email of the user you want to find"
        respond_to do |format|
            format.js { render partial: 'users/friend_result' }
        end
      end
    end  
end
  