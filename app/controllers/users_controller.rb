class UsersController < ApplicationController
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
      # redirect_to register_path, flash: { errors: @user.errors.full_messages }
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
