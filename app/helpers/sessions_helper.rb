module SessionsHelper
  
  def log_in(user)
    session[:user_id] = user.id
  end

  def remember(user)
    user.remember
    cookies.permanent.signed[:user_id] = user.id
    cookies.permanent[:remember_token] = user.remember_token
  end

  def current_user
    # The "if" construction below, when placed between parenthesis,
    # works like this: if session[:user_id] exists, assign it to
    # user_id
    if (user_id = session[:user_id])
      @current_user ||= Cliente.find_by(id: session[:user_id])
    elsif (user_id = cookies.signed[:user_id]) 
      user = Cliente.find_by(id: user_id)
      if user && user.authenticated?(:remember, cookies[:remember_token])
        log_in user
        @current_user = user
      end
    end

    # sessions terminate when a user closes his browser; if the user
    # chooses to be remembered, the code above will set @current_user 
    # according the session data upon a fresh login; it'll also generate a cookie that'll be
    # used on subsequent visits when that first-session-data, ie. the one
    # that generated the cookie in the first place, no longer exists. 
    # So:
    # 1. User logs in and checks the "remember me" box
    # 2. @current_user is set using first-session-data
    # 3. User closes his browser
    # 4. User visits again later; browser sends cookie which app is looking
    # for, finds a valid remember_token/user_id, and logs_in user authomatically in
    # the background, creating new session data in the process.
  end


  def logged_in?
    !current_user.nil? 
  end

  # Returns true if the given user is the current user.
  def current_user?(user)
    user == current_user
  end

  def forget(user)
    user.forget
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end

  def log_out
    forget(current_user)
    session.delete(:user_id)
    @current_user = nil
  end

end
