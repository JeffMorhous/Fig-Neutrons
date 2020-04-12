class InstructorController < ApplicationController
  def create
    @instructor = Instructor.new(first_name: params[:fName], last_name: params[:lName], email: params[:email],
                                  password: params[:password], password_confirmation: params[:confirmPassword])
    if @instructor.save
      log_in @instructor, 'instructor'
      redirect_to :action => 'profile'
    else
      flash[:danger] = @instructor.errors.full_messages
      redirect_to '/user/signup'
    end

  end
  
  def login
    instructor = Instructor.find_by(email: params[:email].downcase)
    if instructor && instructor.authenticate(params[:password])
      session[:user_id] = instructor.id
      redirect_to '/instructor/profile'
    else
      flash[:danger] = "Invalid email/password combination"
      redirect_to '/user/login'
    end
  end

  def recommendation
  end

  def profile
    @instructor = Instructor.find_by id: session[:user_id]
    @instructorName = "#{@instructor.first_name} #{@instructor.last_name}"
  end

  

end
