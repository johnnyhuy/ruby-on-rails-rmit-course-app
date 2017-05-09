class UsersController < ApplicationController
  # Middleware
  before_action :guests_only, only: [:new, :create]

  def edit
    @user = User.find(params[:id])
  end

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
  end

  def create
    # Start a new User
    @user = User.new(user_params)

    # Save user to DB
    if @user.save
      # Handle a successful save.
      redirect_to login_path, flash: { success: 'Successfully registered a coordinator, please login.' }
    else
      render 'new'
    end
  end

  def update
    @user = User.find(params[:id])

    # Get user params
    user_params = params.require(:user).permit([:firstname, :lastname, :email, :password, :password_confirmation])

    @user.update_attribute(:firstname, user_params[:firstname])
    @user.update_attribute(:lastname, user_params[:lastname])
    @user.update_attribute(:email, user_params[:email])

    redirect_to user_path(@user), flash: { success: 'Successfully edited a profile!' }
  end

  private
    def user_params
      if params[:user].nil? or params[:user].empty?
        return false
      else
        return params.require(:user).permit(
          :firstname,
          :lastname,
          :email,
          :password,
          :password_confirmation
        )
      end
    end
end
