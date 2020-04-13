class WelcomeController < ApplicationController
  def index
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
end
