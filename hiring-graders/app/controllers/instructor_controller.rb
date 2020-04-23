class InstructorController < ApplicationController
  def create

    # Check if account with that email already exists
    error = false
    @existing_student = Student.find_by(email: params[:email])
    @existing_admin = Admin.find_by(email: params[:email])
    if @existing_student != nil || @existing_admin != nil
      error = true
    end

    # Create the account and display the appropriate message if there is an error
    if !error
      @instructor = Instructor.new(first_name: params[:fName], last_name: params[:lName], email: params[:email],
        password: params[:password], password_confirmation: params[:confirmPassword])
      if @instructor.save
        log_in @instructor, 'instructor'
        redirect_to :action => 'profile'
      else
        flash[:danger] = @instructor.errors.full_messages
        redirect_to '/user/signup'
      end
    else
      flash[:danger] = "This email is tied to an existing account. Please log in above."
      redirect_to '/user/login'
    end

  end
  
  # Login in the instructor user by authenticating with db and saving id in session
  def login
    instructor = Instructor.find_by(email: params[:email].downcase)
    if instructor && instructor.authenticate(params[:password])
      log_in instructor, 'instructor'
      redirect_to '/instructor/profile'
    else
      flash[:danger] = "Invalid email/password combination"
      redirect_to '/user/login'
    end
  end

  # Rec form
  def recommendation
  end

  # Add a new recommendation to the database
  def create_recommendation
    # Determine if the request checkbox was selected
    recRequest = false
    if params[:recRequest]
      recRequest = true
    end

    @recommend = Recommendation.new(recommendation: params[:recText], student_email: params[:email], first_name: params[:firstName],
                                    last_name: params[:lastName], course_number: params[:recCourse], instructor_id: session[:user_id], request: recRequest)

    if @recommend.save
      flash[:success] = "Your recommendation was saved successfully!"
      redirect_to '/instructor/profile'
    else
      flash.now[:danger] = @recommend.errors.full_messages
    end
  end

  # Update an existing recommendation
  def update_recommendation

    # Determine if the request checkbox was selected
    recRequest = false
    if params[:recRequest]
      recRequest = true
    end
    recommendation = Recommendation.find_by(id: params[:id])
    if recommendation.update(recommendation: params[:recText], student_email: params[:email], first_name: params[:firstName],
                          last_name: params[:lastName], course_number: params[:recCourse], instructor_id: session[:user_id], request: recRequest)
      flash[:success] = "Your recommendation was updated successfully!"
      redirect_to '/instructor/edit_recommendation'

    else
      flash.now[:danger] = recommendation.errors.full_messages
    end

  end


  # Retrieve all the submitted recommendations by the instructor to show in the edit recommendations view
  def edit_recommendation
    @recommendations = Recommendation.where(instructor_id: session[:user_id])
  end

  # Retrieve the specific recommendation form that is to be edited
  def edit
    @recommendation = Recommendation.find_by(id: params[:id])
  end

  # Instructor Profile 
  def profile
    @instructor = Instructor.find_by id: session[:user_id]
    if !@instructor.nil?
      @instructorName = "#{@instructor.first_name} #{@instructor.last_name}"
    else
      redirect_to '/user/login'
    end
  end



end
