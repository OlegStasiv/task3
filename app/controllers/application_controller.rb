class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include SessionsHelper


  def authenticate
    user_token = request.headers["Token"]

    @current_user = User.find_by(token: user_token)

    if !user_token || !@current_user
      render json: {error_message: "Token invalid"}, status: 422
    end


  end

end
