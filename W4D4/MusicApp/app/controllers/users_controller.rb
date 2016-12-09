class UsersController < ApplicationController
  before_action :require_current_user!, only: :show
  before_action :require_logged_out!, only: :new

  def new
  end

  def show
    @user = User.find_by_id(params[:id])
  end

  def create
    @user = User.new(user_params)

    if @user.save
      flash[:notices] = ["Welcome to our app! Check your email to validate your account."]
      msg = UserMailer.welcome_email(@user)
      msg.deliver
    else
      flash.now[:errors] = @user.errors.full_messages
    end

    render :new
  end

  def activate
    user = User.find_by_activation_token(params[:activation_token])

    if user.nil?
      flash.now[:errors] = ["No account found with this activation token"]
      render :new
    elsif user.activated
      flash[:errors] = ["Account already activated"]
      redirect_to new_session_url
    else
      user.toggle(:activated)
      flash[:notices] = ["Successfully activated account!"]
      log_in!(user)
      redirect_to user_url(user)
    end
  end
end
