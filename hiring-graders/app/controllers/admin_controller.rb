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
      if(Transcript.exists?(student_id: student.id, course_id: course.course_number))
        intime = true
        if(course.is_lab)
          days = (course.days).chars
          i=0 
          while i < days.length && intime
            day = days[i];
            availabilitys = Availability.where(student_id: student.id, day: day)
            hours = Array.new
            availabilitys.each do |available|
              hours.push(available.hour)
            end
            start_time = (course.start_time.tr(':','')).to_i
            start_time = (start_time/100);
            end_time = (course.end_time.tr(':','')).to_i
            end_time = ((end_time+99)/100);
            time = start_time
            while time <= end_time && intime
              addon = 'PM'
              if(time/12 == 0)
                addon = 'AM'
              end
              standard_time = time
              if standard_time > 12
                standard_time = standard_time - 12
              end
              time_string = standard_time.to_s + ":00" + addon
              if(!hours.include?(time_string))
                intime = false
              end
              time = time +1
            end
            i = i+1
          end
        end 
        if(intime)
          applicants[counter] = student
          counter = counter+1
        end
      end
    end
    @students = applicants

    if(params[:grader_id])
      @grader = Student.find(params[:grader_id])
      @recommendations = Recommendation.where(email: @grader.email)
    end
  end

  def dashboard
    admin = Admin.find_by id: session[:user_id]
    if admin == nil
      redirect_to '/user/login'
    else
      @courses = Course.where(have_grader: false)
    end
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
