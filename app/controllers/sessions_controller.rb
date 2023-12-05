class SessionsController < ApplicationController
  def new
    render 'login_success' if logged_in?
  end

  def create
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      login user
      flash[:success] = 'Login successfully'
    else
      flash[:danger] = 'Invalid email or password'
    end
    redirect_to new_session_path
  end

  def destroy
    session.delete(:user_id)
    @current_user = nil
  end
end
