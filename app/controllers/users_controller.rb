class UsersController < ApplicationController
  # Middleware
  before_action :guests_only, only: [:new, :create]
  before_action :admin_only, only: [:destroy]
  before_action :not_admin, only: [:edit]

  def destroy
    user = User.find(params[:id]).destroy
    flash_success("Successfully deleted #{user.full_name} user!", users_path)
  end

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

    @user.assign_attributes(user_params)

    if @user.save
      redirect_to user_path(@user), flash: { success: 'Successfully updated profile!' }
    else
      render 'edit'
    end
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
