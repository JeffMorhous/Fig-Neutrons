module SessionsHelper

  # Logs in the given user.
  def log_in(user, role)
    session[:user_email] = user.email
    session[:role] = role
  end

  # Returns true if there is a currently logged in user
  def is_logged_in?
    !session[:user_email].nil?
  end

  # Logs out the current logged-in user.
  def log_out
    session.delete(:user_email)
    session.delete(:role)
  end

  def get_role
    session[:role]
  end

end
