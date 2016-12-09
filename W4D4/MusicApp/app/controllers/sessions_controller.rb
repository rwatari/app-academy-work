class SessionsController < ApplicationController
  before_action :require_logged_out!, only: :new

  def new
  end

  def create
    @user = User.find_by_credentials(user_params)

    if @user
      flash[:notices] = ["Welcome back!"]
      @user.reset_session_token!
      log_in!(@user)
      redirect_to user_url(@user)
    else
      flash.now[:errors] = ["No user found with given credentials"]
      render :new
    end
  end

  def destroy
    log_out!
    redirect_to new_session_url
  end
end
