class StudentController < ApplicationController
  before_action :is_student?
  skip_before_action :is_student?, only: [:login, :create]
  
  def create
    # Check if account with that email already exists
    error = false
    @existingInstructor = Instructor.find_by(email: params[:email])
    @existingAdmin = Admin.find_by(email: params[:email])
    if @existingInstructor != nil || @existingAdmin != nil
      error = true
    end

    # Create the account and display the appropriate message if there is an error
    if !error
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
    else
      flash[:danger] = "This email is tied to an existing account. Please log in above."
      redirect_to '/user/login'
    end
  end
  
  def login
    student = Student.find_by(email: params[:email].downcase)
    if student && student.authenticate(params[:password])
      log_in student, 'student'
      redirect_to '/student/profile'
    else
      flash[:danger] = "Invalid email/password combination"
      redirect_to '/user/login'
    end

  end

  # Convert the letter entered to a grade
  def convert_letter_grades_to_gpa(grade)
    if grade == 'A' then return 93 end
    if grade == 'A-' then return 90 end
    if grade == 'B+' then return 87 end
    if grade == 'B' then return 83 end
    if grade == 'B-' then return 80 end
    if grade == 'C+' then return 77 end
    if grade == 'C' then return 73 end
    if grade == 'C-' then return 70 end
    if grade == 'D+' then return 67 end
    if grade == 'D' then return 60 end
    if grade == 'E' then return 0 end
    return nil
  end

  # Convert the stored number to a letter to display
  def convert_number_to_letter_grade(grade)
    if grade == 93 then return 'A' end
    if grade == 90 then return 'A-' end
    if grade == 87 then return 'B+' end
    if grade == 83 then return 'B' end
    if grade == 80 then return 'B-' end
    if grade == 77 then return 'C+' end
    if grade == 73 then return 'C' end
    if grade == 70 then return 'C-' end
    if grade == 67 then return 'D+' end
    if grade == 60 then return 'D' end
    if grade == 0 then return 'E' end
    if grade == nil then return 'E' end
  end

  def application
    @student = Student.find_by email: session[:user_email]
    @grades = Array.new
    @found_interested_entry = false;

    # Retrieve student's existing info when loading the application
    if !@student.nil?
      @student_name = "#{@student.first_name} #{@student.last_name}"
      @student_grades = Transcript.where student_id: @student.id
      @student_grades.each_with_index do |transcript, index|
        @grades[index] = convert_number_to_letter_grade(transcript.grade)
      end
    end
    @interested_courses = Interested.where student_id: @student.id

    # Save the information entered in the dynamic form for collecting grades
    error = false;
    if request.post? 
      index = 1
      grade_string = "grade" + index.to_s
      course_string = "courseNum" + index.to_s
      interested_string = "gradeInterest" + index.to_s
      all_transcripts = Transcript.where student_id: @student.id
      num_of_grades = all_transcripts.size
      while params[grade_string] != nil

        # Check for errors on input form:
        # incorrect course number entered
        error = true if !params[course_string].match(/^\d{4}/)

        # incorrect grade entered
        error = true if convert_letter_grades_to_gpa(params[grade_string].upcase) == nil

        # missing values for course num or grade
        if params[grade_string].length == 0 || params[course_string].length == 0
          error = true

          # if it's the last row of input fields then empty fields are okay
          index = index + 1
          grade_string = "grade" + index.to_s
          if !params[grade_string]
            error = false
            index = index - 1
            grade_string = "grade" + index.to_s
          end
        end
        break if error

        # Look up interest and transcript information of student
        grade_interest = Interested.find_by(student_id: @student.id, course: params[course_string])
        transcript = Transcript.find_by(student_id: @student.id, course_id: params[course_string])

        # If the request to grade box is no longer checked and was previously checked, destroy the record 
        if grade_interest != nil && !params[interested_string]
          grade_interest.destroy
        elsif !grade_interest && params[interested_string]
          # Create a new record for interest if there is not an existing record and the student has selected the checkbox
          grade_interest = Interested.new(student_id: @student.id, department: "CSE", course: params[course_string])
          grade_interest.save
        end

        # if the student had an existing entry that they're updating that needs to be changed
        if index <= num_of_grades
          transcript = all_transcripts[index - 1]
          transcript.grade = convert_letter_grades_to_gpa(params[grade_string].upcase)
          transcript.course_id = params[course_string]
          transcript.updated_at = Time.new
        else
          # Otherwise create a new record
          transcript = Transcript.new(
              grade: convert_letter_grades_to_gpa(params[grade_string].upcase),
              created_at: Time.new,
              updated_at: Time.new,
              student_id: @student.id,
              course_id: params[course_string])
        end

        # Only save if there is information entered in the course num and grade fields
        transcript.save unless params[course_string].length == 0 || params[grade_string].length == 0
        transcript_save_error = transcript.errors.full_messages.length > 0
        # Update the name of the input row to check
        index = index + 1
        grade_string = "grade" + index.to_s
        course_string = "courseNum" + index.to_s
        interested_string = "gradeInterest" + index.to_s
      end

      # Show the appropriate error/success message based on form validation and success of saving info
      if error 
        flash[:danger] = "Please enter a valid course number/grade"
        if flash[:success]
          flash[:success] = nil
        end
      elsif transcript_save_error
        flash[:danger] = transcript.errors.full_messages.length
        if flash[:success]
          flash[:success] = nil
        end
      else
        flash[:success] = "Your grades have been saved successfully."
        if flash[:danger]
          flash[:danger] = nil
        end
      end

      redirect_to '/student/application'
    end

  end

  # Save the hours entered from the availability table
  def availability
    student_id = Student.find_by(email: session[:user_email]).id
    Availability.where(student_id: student_id).destroy_all
    if params[:"0"]
      params[:"0"].each do |item|
        Availability.create(student_id: student_id, day: "M", hour: item )
      end
    end
    if params[:"1"]
      params[:"1"].each do |item|
        Availability.create(student_id: student_id, day: "T", hour: item )
      end
    end
    if params[:"2"]
      params[:"2"].each do |item|
        Availability.create(student_id: student_id, day: "W", hour: item )
      end
    end
    if params[:"3"]
      params[:"3"].each do |item|
        Availability.create(student_id: student_id, day: "R", hour: item )
      end
    end
    if params[:"4"]
      params[:"4"].each do |item|
        Availability.create(student_id: student_id, day: "F", hour: item )
      end
    end
    redirect_to '/student/profile'
  end
  

  def profile
    @no_hours_selected = false
    all_courses = Course.all
    @graders_required = false
    @start = Time.new(2020, 4, 20)
    @year = true

    # Determine if there are courses that still needs graders to show the right application status
    all_courses.each do |course|
      if course.need_grader && !course.have_grader
        @graders_required = true
      end
      break
    end

    # Retrieve the student's current availability and query the courses to grade for the student
    @student = Student.find_by(email: session[:user_email])
    @student_name = "#{@student.first_name} #{@student.last_name}"
    @transcript = Transcript.find_by(student_id: @student.id)
    @monday = Availability.where(student_id: @student.id, day: "M")
    @tuesday = Availability.where(student_id: @student.id, day: "T")
    @wednesday = Availability.where(student_id: @student.id, day: "W")
    @thursday = Availability.where(student_id: @student.id, day: "R")
    @friday = Availability.where(student_id: @student.id, day: "F")

    if @monday.length == 0 && @tuesday.length == 0 && @wednesday.length == 0 && @thursday.length == 0 && @friday.length == 0
      @no_hours_selected = true
    end

      @courses_to_grade = Grader.where(student_id: @student.id)
  end

  # Check if the user has a student account
  def is_student?
    if !session[:user_email] && !Student.find_by(email: session[:user_email])
      redirect_to '/user/signup'
    end
  end



end