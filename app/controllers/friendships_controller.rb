class FriendshipsController < ApplicationController
    def create
        current_user.friendships.build(friend_id: params[:friend])
        if current_user.save
            flash[:notice] = "Following friend"
            friend = User.where(id:params[:friend]).first
            if friend.not_friends_with?(current_user)
                FriendMailer.add_friend_back(friend, current_user).deliver_now
            end
            redirect_to user_path(params[:friend])
        else
            flash[:alert] = "There was something wrong adding this user as your friend"
            redirect_to search_friend_path
        end
    end
  
    def destroy
      friendship = current_user.friendships.where(friend_id: params[:id]).first
      friendship.destroy
      flash[:notice] = "Stopped following"
      redirect_to my_friends_path
    end
end