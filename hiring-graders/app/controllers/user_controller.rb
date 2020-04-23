class UserController < ApplicationController
  # function to determine which sign up role/which page the user should be directed to after sign up
  def signup
    @account_page = true
    if is_logged_in?
      if get_role == 'student'
        redirect_to '/student/profile'
        return
      elsif get_role == 'instructor'
        redirect_to '/instructor/profile'
        return
      elsif get_role == 'admin'
        redirect_to '/admin/dashboard'
        return
      end
    end
  end

  # function to redirect to the correct page after log in
  def login
    @account_page = true
    if is_logged_in?
      if get_role == 'student'
        redirect_to '/student/profile'
        return
      elsif get_role == 'instructor'
        redirect_to '/instructor/profile'
        return
      elsif get_role == 'admin'
        redirect_to '/admin/dashboard'
        return
      end
    end
  end

  # function to redirect to the log in page
  def logout
    log_out
    redirect_to '/user/login'
  end

end
