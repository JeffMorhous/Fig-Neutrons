class AdminController < ApplicationController
  def login
    admin = Admin.find_by(email: params[:email].downcase)
    if admin && admin.authenticate(params[:password])
      log_in admin
      redirect_to '/admin/dashboard'
    else
      flash[:danger] = "Invalid email/password combination"
      redirect_to '/user/login'
    end
  end

  def dashboard
    @courses = Course.all
  end

  def findclass
        course = Course.find_by(course: params[:id]
      session[:course] = course
      redirect_to '/admin/class'
  end

  def class
    course = session[:course]
    @name = course.department + "" + course.course
  end
end
