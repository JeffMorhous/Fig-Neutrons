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
      log_in student, 'student'
      redirect_to '/student/profile'
    else
      flash[:danger] = "Invalid email/password combination"
      redirect_to '/user/login'
    end

  end

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
    return 60
  end

  def convert_number_to_letter_grade(grade)
    if grade == 93 then return 'A' end
    if grade == 90 then return 'A-' end
    if grade == 87 then return 'B+' end
    if grade == 83 then return 'B' end
    if grade == 80 then return 'B-' end
    if grade == 77 then return 'C+' end
    if grade == 73 then return 'C' end
    if grade == 70 then return 'C-' end
    if grade == 67 then return 'D' end
  end

  def application
    @student = Student.find_by id: session[:user_id]
    @grades = Array.new()
    @foundInterestedEntry = false;
    if !@student.nil?
      @studentName = "#{@student.first_name} #{@student.last_name}"
      @studentGrades = Transcript.where student_id: @student.id
      @studentGrades.each_with_index do |transcript, index|
        @grades[index] = convert_number_to_letter_grade(transcript.grade)
      end
    end
    @interestedCourses = Interested.where student_id: @student.id


    if request.post? 
      index = 1
      gradeString = "grade" + index.to_s
      courseString = "courseNum" + index.to_s
      interestedString = "gradeInterest" + index.to_s
      while params[gradeString] != nil && params[gradeString].length > 0
        if params[interestedString]
        end
        gradeInterest = Interested.find_by(student_id: @student.id, course: params[courseString])
        transcript = Transcript.find_by(student_id: @student.id, course_id: params[courseString])
        if gradeInterest != nil && !params[interestedString]
          gradeInterest.destroy
        elsif !gradeInterest && params[interestedString]
          gradeInterest = Interested.new(student_id: @student.id, department: "CSE", course: params[courseString])
          gradeInterest.save
        end

        if transcript != nil
          transcript.grade = convert_letter_grades_to_gpa(params[gradeString])
          transcript.updated_at = Time.new
        else
          transcript = Transcript.new(
              grade: convert_letter_grades_to_gpa(params[gradeString]),
              created_at: Time.new,
              updated_at: Time.new,
              student_id: @student.id,
              course_id: params[courseString])
        end
        transcript.save
        index = index + 1
        gradeString = "grade" + index.to_s
        courseString = "courseNum" + index.to_s
        interestedString = "gradeInterest" + index.to_s
      end
      redirect_to '/student/application'
    end

  end

  def availability
    Availability.where(student_id: session[:user_id]).destroy_all
    if params[:"0"]
      params[:"0"].each do |item|
        Availability.create(student_id: session[:user_id], day: "M", hour: item )
      end
    end
    if params[:"1"]
      params[:"1"].each do |item|
        Availability.create(student_id: session[:user_id], day: "T", hour: item )
      end
    end
    if params[:"2"]
      params[:"2"].each do |item|
        Availability.create(student_id: session[:user_id], day: "W", hour: item )
      end
    end
    if params[:"3"]
      params[:"3"].each do |item|
        Availability.create(student_id: session[:user_id], day: "R", hour: item )
      end
    end
    if params[:"4"]
      params[:"4"].each do |item|
        Availability.create(student_id: session[:user_id], day: "F", hour: item )
      end
    end
    redirect_to '/student/profile'
  end
  

  def profile
    @student = Student.find_by id: session[:user_id]
    @grades = Array.new()

    if !@student.nil?
      @studentName = "#{@student.first_name} #{@student.last_name}"
      @monday = Availability.where(student_id: session[:user_id], day: "M")
      @tuesday = Availability.where(student_id: session[:user_id], day: "T")
      @wednesday = Availability.where(student_id: session[:user_id], day: "W")
      @thursday = Availability.where(student_id: session[:user_id], day: "R")
      @friday = Availability.where(student_id: session[:user_id], day: "F")
    end
  end


end