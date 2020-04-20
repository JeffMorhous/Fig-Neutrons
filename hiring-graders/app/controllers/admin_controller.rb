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
    course = Course.find(params[:section_id])
    @class = "CSE " +course.course_number
    @section = course.section_number
    @courses = Course.all
    @course = course

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

    if(params[:grader_id])
      @grader = Student.find(params[:grader_id])
      student_recommendations = Recommendation.where(student_id: @grader.id)
      recommends = {};
      counter = 0;
      student_recommendations.each do |recommend|
        teacher = Instructor.find(recommend.instructor_id)
        recommends[counter] = {teacher: teacher.first_name + " " + teacher.last_name, course: recommend.course_id, recommendation: recommend.recommendation}
      end
      @recommentations = recommends
    end
  end

  def dashboard
    @courses = Course.all
  end

  def select
    student = Student.find(params[:student_id]) 
    course = Course.find(params[:course_id])
    grader = Grader.new(course_id: params[:course_id], student_id: params[:student_id], semester: 'Fall')
    grader.save
    course.have_grader = true
    course.save
    redirect_to '/admin/dashboard'
  end

  def selection
    redirect_to '/admin/section'
  end
end
