module SessionsHelper
  # Logs in the given user.
  def login(user)
    # Set the session user ID from the selected user
    session[:user_id] = user.id
  end

  def remember(user)
    # Remember selected user
    user.remember

    # Set permanent signed (encrypted) user ID
    cookies.permanent.signed[:user_id] = user.id

    # Set premanent remember token
    cookies.permanent[:remember_token] = user.remember_token
  end

  def forget(user)
    user.forget
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end

  # Logout by deleting session
  def logout
    forget current_user
    session.delete(:user_id)
    @current_user = nil
  end

  # Returns the current logged-in user (if any).
  def current_user
    if user_id = session[:user_id]
      # Find by session user ID
      @current_user ||= User.find_by(id: user_id)
    elsif user_id = cookies.signed[:user_id]
      # Find by cookies user ID
      user = User.find_by(id: user_id)
      if user and user.authenticated?(cookies[:remember_token])
        # Login user
        login user

        # Make current logged in user as found user
        @current_user = user
      end
    end
  end

  # Returns true if the user is logged in, false otherwise.
  def logged_in?
    !current_user.nil?
  end

  # Redirect to login if not logged in
  def logged_users_only
    redirect_to login_path if !logged_in?
  end

  # Redirect to root if logged in
  def guests_only
    redirect_to root_path if logged_in?
  end
end
