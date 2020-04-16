class AdminController < ApplicationController
  def login
    admin = Admin.find_by(email: params[:email].downcase)
    if admin && admin.authenticate(params[:password])
      log_in admin, 'admin'
      redirect_to '/admin/dashboard'
    else
      flash[:danger] = "Invalid email/password combination"
      redirect_to '/user/login'
    end
  end

  def section
    course = Course.find_by(id: params[:id])
    @class = course.department+ " " +course.class_number

  end

  def dashboard
    @courses = Course.all
  end
end
