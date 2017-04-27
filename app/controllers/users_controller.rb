class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(user_params)    # Not the final implementation!
    if @user.save
      redirect_to register_path, flash: { notice: 'Successfully registered a coordinator, please login.' }
      # Handle a successful save.
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
          :name,
          :email,
          :password,
          :password_confirmation
        )
      end
    end
end
