class API::V1::FriendshipsController < ApplicationController
  skip_before_filter :verify_authenticity_token


  def create
    user_token = request.headers["Token"]
    @current_user = User.find_by(token: user_token)

    @friendship = @current_user.friendships.build(:friend_id => params[:friend_id], :approved => false)
    if @friendship.save
      render json: @friendship
    else
      render json: {error: "Something broke"}, status: 401
    end
  end

  def update
    user_token = request.headers["Token"]
    @current_user = User.find_by(token: user_token)
    @friendship = Friendship.where(friend_id: current_user, user_id: params[:id]).first
    @friendship.update(approved: true)
    if @friendship.save!
      render json: @friendship
    else
      render json: {error: "Something broke"}, status: 401
    end
  end

  def my_friends
    user_token = request.headers["Token"]
    @current_user = User.find_by(token: user_token)
    @myfriends = @current_user.friends
    render json: @myfriends
  end

  def who_want
    user_token = request.headers["Token"]
    @current_user = User.find_by(token: user_token)
    @whowant = @current_user.requested_friendships

    render json: @whowant
  end

  def destroy
    user_token = request.headers["Token"]
    @current_user = User.find_by(token: user_token)
    @friendship = Friendship.where(friend_id: [@current_user, params[:id]]).where(user_id: [@current_user, params[:id]]).last
    if @friendship.destroy
      render json: @myfriends
    else
      render json: {error: "Something broke"}, status: 401
    end

  end






end