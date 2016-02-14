class API::V1::UsersController < ApplicationController
  skip_before_filter :verify_authenticity_token
  before_action :authenticate, :except => [:create,:login]


  def create
    @user = User.create(user_params)

    if @user.save
      render json: {user: @user}, status: 200
    else
      render json: @user.errors, status: 403
    end

  end

  def show
    @user = User.find(params[:id])
  end


  def login
    @user = User.find_by(email: params[:email])
    if @user && @user.authenticate(params[:password])

      @user.token = @user.generate_auth_token
      if @user.save!
        render json: {data: {token: @user.token}}, status: 200
      else
        render json: {error: "Login error"}, status: 422
      end
    else
      render json: {error: "User not found"}, status: 401
    end
  end


def profile
  user_token = request.headers["Token"]
  @user = User.find_by_token(user_token)

  if @user.update_attributes(user_params)
    render json: @user
  else
    render json: {error: "Was not updated"}, status: 401
  end
end


private

  def user_params
    params.permit(:name, :email, :password, :password_confirmation)
  end


  def authenticate_token
    authenticate_with_http_token do |token, options|
      User.find_by(token: token)
    end
  end
end




