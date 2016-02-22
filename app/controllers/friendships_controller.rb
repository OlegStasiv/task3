class FriendshipsController < ApplicationController

  skip_before_action :verify_authenticity_token

  def show
    @friends = Friendship.find_by_approved(true)
  end
  def new

  end
  def create
    @friendship = current_user.friendships.build(:friend_id => params[:friend_id], :approved => false)
    if @friendship.save
      flash[:notice] = "Friend requested."
      redirect_to users_path
    else
      flash[:error] = "Unable to request friendship."
      redirect_to :back
    end
  end

  # PATCH/PUT /friendships/1
  # PATCH/PUT /friendships/1.json
  def update
    @friendship = Friendship.where(friend_id: current_user, user_id: params[:id]).first
    @friendship.update(approved: true)
    if @friendship.save!
      redirect_to '/users', :notice => "Successfully confirmed friend!"
    else
      redirect_to root_url, :notice => "Sorry! Could not confirm friend!"
    end
  end

  # DELETE /friendships/1
  # DELETE /friendships/1.json
  def destroy
    @friendship = Friendship.where(friend_id: [current_user, params[:id]]).where(user_id: [current_user, params[:id]]).last
    @friendship.destroy
    flash[:notice] = "Friend deleted."
    redirect_to '/users'
  end


end
