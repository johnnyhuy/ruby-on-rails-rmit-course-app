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
    if session[:user_id]
      # Find by session user ID
      @current_user ||= User.find_by(id: session[:user_id])
    elsif cookies[:user_id]
      # Find by cookies user ID
      user = User.find_by(id: cookies.signed[:user_id])

      if user and user.authenicated?(cookies[:remember_token])
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
end
