class SessionsController < ApplicationController
  # Middleware
  before_action :logged_users_only, only: :destroy

  def new
  end

  def create
    remember_me ||= params[:session][:remember_me]
    user = User.find_by(email: params[:session][:email].downcase)

    if user and user.authenticate(params[:session][:password])
      # Check if remember me param is true
      remember_me == '1' ? remember(user) : forget(user)

      # Show success message
      flash[:success] = 'Successfully logged in.'

      # Set a session through login function
      login user

      # Redirect to login page
      redirect_to root_path
    else
      # Show error
      flash[:danger] = 'Invalid password/email, please try again.'

      # Render login form again
      render 'new'
    end
  end

  def destroy
    if logged_in?
      logout
      redirect_to root_path, flash: { success: 'Successfully logged out.' }
    end
  end
end
