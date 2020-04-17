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
    @class = course.department+ " " +course.course_number
    @section = course.section_number

    if(course.instructor)
      @teacher = course.instructor
    else
      @teacher= "N/A"
    end  

    if(!course.location.strip.empty?)
      @location = course.location
    else
      @location = "N/A"
    end  

    if(course.days && course.start_time && course.end_time)
      @time = course.days+ " " +course.start_time+ "-" +course.end_time
    else
      @time = "N/A"
    end 

    applicants = Array.new
    counter = 0
    (Student.all).each do |student|
      if((Transcript.exists?(student_id: student.id, course_id: course.id)))
        applicants[counter] = student
        counter = counter+1
      end
      # && (!(Course.exists?(section_number: course.section_number, is_lab: true) || (Course.exists?(section_number: course.section_number, is_lab: true) && ) 
    end
    @students = applicants
  end

  def dashboard
    @courses = Course.all
  end
end
