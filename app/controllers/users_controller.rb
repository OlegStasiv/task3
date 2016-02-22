class UsersController < ApplicationController
  skip_before_filter :verify_authenticity_token
  def index
    @users = User.all

  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      sign_in @user
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user
    else
      render 'new'
    end
  end
  def edit
    @user = User.find_by(params[:id])
  end
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Profile is updated successfully!"
      redirect_to @user
    else
      render 'edit'
    end
  end




  private
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end


end
