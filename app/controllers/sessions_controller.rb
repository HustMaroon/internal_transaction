class SessionsController < ApplicationController
  def new
    render 'login_success' if logged_in?
  end

  def create
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      login user
      flash[:success] = 'Login successfully'
      redirect_to new_session_path
    else
      flash[:danger] = 'Invalid email or password'
      render 'new'
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to new_session_path
  end
end
