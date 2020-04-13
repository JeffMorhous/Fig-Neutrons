class StudentController < ApplicationController
  def create
    @student = Student.new(first_name: params[:fName],
                           last_name: params[:lName],
                           email: params[:email],
                           phone: params[:phone],
                           password: params[:password],
                           password_confirmation: params[:confirmPassword])
    if @student.save
      log_in @student, 'student'
      redirect_to :action => 'profile'
    else
      flash[:danger] = @student.errors.full_messages
      redirect_to '/user/signup'
    end

  end
  
  def login
    student = Student.find_by(email: params[:email].downcase)
    if student && student.authenticate(params[:password])
      session[:user_id] = student.id
      redirect_to '/student/profile'
    else
      flash[:danger] = "Invalid email/password combination"
      redirect_to '/user/login'
    end

  end

  def application
    @student = Student.find_by id: session[:user_id]
    @studentName = "#{@student.first_name} #{@student.last_name}"
  end

  def availability
  end
  

  def profile
    @student = Student.find_by id: session[:user_id]
    @studentName = "#{@student.first_name} #{@student.last_name}"
    @studentGrades = Transcript.find_by student_id: @student.id
    unless @studentGrades.nil?
      @grade = @studentGrades.grade
      @course = @studentGrades.course_id
    end

  end


end