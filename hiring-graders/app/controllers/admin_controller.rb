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
        course = Course.find_by(section: params[:email].downcase)
    if student && student.authenticate(params[:password])
      session[:user_id] = student.id
      redirect_to '/student/profile'
  end

  def class
    @name = 
  end
end
