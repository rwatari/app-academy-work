class UsersController < ApplicationController
  before_action :require_current_user!, only: :show
  def new
  end

  def show
    @user = User.find_by_id(params[:id])
  end

  def create
    @user = User.new(user_params)

    if @user.save
      flash[:notices] = ["Welcome to our app!"]
      log_in!(@user)
      redirect_to user_url(@user)
    else
      flash.now[:errors] = @user.errors.full_messages
      render :new
    end
  end
end
