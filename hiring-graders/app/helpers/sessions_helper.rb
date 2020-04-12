module SessionsHelper

  # Logs in the given user.
  def log_in(user, role)
    session[:user_id] = user.id
    session[:role] = role
  end

  # Returns true if there is a currently logged in user
  def is_logged_in?
    !session[:user_id].nil?
  end

  # Logs out the current logged-in user.
  def log_out
    session.delete(:user_id)
    session.delete(:role)
  end

  def get_role
    session[:role]
  end

end
