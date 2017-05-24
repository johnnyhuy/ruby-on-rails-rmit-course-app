class SessionsController < ApplicationController
  # Middleware
  before_action :logged_users_only, only: :destroy
  before_action :guests_only, only: [:new, :create]

  def new
  end

  def create
    email = params[:session][:email]
    password = params[:session][:password]
    remember_me ||= params[:session][:remember_me]

    # Find user by email
    user = User.find_by(email: email.downcase)

    # If user wants to login as admin
    return redirect_to root_path if login_admin(email, password)

    if user and user.authenticate(password)
      # Check if remember me param is true
      remember_me == '1' ? remember(user) : forget(user)

      # Set a session through login function
      login user

      # Redirect to home page
      flash_success('Successfully logged in.', root_path)
    else
      # Show error
      flash_danger('Invalid password/email, please try again.')

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
