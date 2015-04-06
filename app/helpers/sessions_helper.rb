module SessionsHelper

  #Logs in the user
  def log_in(user)
    session[:user_id] = user.id
  end

  def log_out
    forget(current_user)
    session.delete(:user_id)
    @current_user = nil
  end

  def forget(user)
    user.forget
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end

  def current_user?(user)
    user == current_user
  end

  #Returns the current logged-in user corresponding to the remember token cookie
  def current_user
    #Using sessions
    if (user_id = session[:user_id])
      @current_user ||= User.find_by(id: user_id)
      #using secured cookies (if the user marked the "remember me" checkbox)
    elsif (user_id = cookies.signed[:user_id])
      user = User.find_by(id: user_id)
      if user && user.authenticated?(cookies[:remember_token])
        log_in user
        @current_user = user
      end
    end
  end

  def logged_in?
    !current_user.nil?
  end

  #Remember the user using secured cookies
  def remember(user)
    #Call remember first to save the new remember digest on the database
    #this method also sets the remember_token variable
    user.remember
    cookies.permanent.signed[:user_id] = user.id
    cookies.permanent[:remember_token] = user.remember_token
  end

  #Redirects to stored location (or to the default)
  def redirect_back_or(default)
    #redirect the user to the last url that he attepted to access
    #before his login
    redirect_to(session[:forwarding_url] || default)
    #delete the stored URL
    session.delete(:forwarding_url)
  end

  def store_location
    #store the URL if it is a GET request
    session[:forwarding_url] = request.url if request.get?
  end



end




























