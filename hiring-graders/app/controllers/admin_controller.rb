require 'rubygems'
require 'mechanize'
class AdminController < ApplicationController
  
  #login handling for the admin pages
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

  #handles the entire section page
  def section
    
    #setup basic info needed for the section page
    course = Course.find(params[:section_id])
    @class = "CSE " +course.course_number
    @section = course.section_number
    @courses = Course.all
    @course = course
    @graders = Grader.where(course_id: course.id)

    #setup the data needed for the class info
    if course.instructor
      @teacher = course.instructor
    else
      @teacher = "N/A"
    end  

    if !course.location.strip.empty?
      @location = course.location
    else
      @location = "N/A"
    end  

    if course.days && course.start_time && course.end_time
      @time = course.days+ " " +course.start_time+ "-" +course.end_time
    else
      @time = "N/A"
    end

    #process of selecting all of the available graders
    applicants = Array.new
    counter = 0
    (Student.all).each do |student|
      
      #get possible graders transcript and check that they got an A- or above in this course
      transcript = Transcript.find_by(student_id: student.id, course_id: course.course_number)
      if(transcript && transcript.grade >= 90 && !Grader.exists?(student_id: student.id, course_id: course.id))
        
        #check if their availability is needed to be checked
        intime = true
        if course.is_lab
          classes_grading = Grader.where(student_id: student.id)
          i=0
          if classes_grading
            while i < classes_grading.length && intime
              section = Course.find(classes_grading[i].course_id)
              if(section.is_lab)
                days = (section.days).chars
                j=0
                while j < days.length && intime
                  if (course.days).include?(days[j]) && ((course.start_time <= section.start_time && section.start_time <= course.end_time) || (course.end_time <= section.start_time && section.end_time <= course.end_time))
                    intime=false
                  end
                  j = j+1
                end
              end
              i = i+1
            end
          end
          #check the days for the course and check what time the student is available for these days
          days = (course.days).chars
          i=0 
          while i < days.length && intime
            day = days[i];
            availabilitys = Availability.where(student_id: student.id, day: day)
            hours = Array.new
            availabilitys.each do |available|
              hours.push(available.hour)
            end
            
            #convert the course time to the fit the student availability format
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
              
              #check if the student availability works with the current course time
              if !hours.include?(time_string)
                intime = false
              end
              time = time +1
            end
            i = i+1
          end
        end

        #add applicant to array if they are qualified for the position 
        if intime
          applicants[counter] = student
          counter = counter+1
        end
      end
    end
    @students = applicants

    #if a student has been selected for more information
    if params[:grader_id]
      @grader = Student.find(params[:grader_id])
      @recommendations = Recommendation.where(student_email: @grader.email)
      @evaluations = Evaluation.where(student_id: @grader.id)
    end
  end

  #basic view for the main dashboard
  def dashboard
    admin = Admin.find_by id: session[:user_id]
    if admin == nil
      redirect_to '/user/login'
    else
      @courses = Course.all
      @semesters = Semester.all
    end

  end

  def get_courses
    # Scrape the CSE Course info page to seed the database with all the course and section information

    Course.delete_all
    Semester.delete_all
    Grader.delete_all
    agent = Mechanize.new

    # Use mechanize to scrape the OSU CSE course information website
    page = agent.get('https://web.cse.ohio-state.edu/oportal/schedule_display/')
    form = page.form_with(:dom_id => 'filter')
    form.field_with(:name => 'strm').options.each do |semester|
      semester.click
      semester_page = form.submit.parser
      Semester.create(semester: semester.text)
      hash_map = Hash.new

      # Retrieve all the links and for each link find its id (course number) and title (course title)
      links = semester_page.css('a')
      links.each do |item|
        course_number = item.attribute('href')
        course_title = item.text

        # Create a hash that maps the course number to the course title
        hash_map[course_number.to_s] = course_title
      end

      # Find all the rows for each table to get the information for each section of a course
      # and add each section to the database
      tables = semester_page.css("tr.group0, tr.group1")
      tables.each do |item|
        
        # Use the course id to find the title of the section's course
        course_title = hash_map["#" + item.parent.parent.parent.attribute('id')]
        course_title_array = course_title.split(" ")
        section_data = item.text.split("\n")
        time = section_data[4].split(" ")
        isLab = section_data[2].include? "LAB"
        if time.length > 1
          Course.create(department: course_title_array[0],
                        section_number: section_data[1].strip!,
                        course_number: course_title_array[1],
                        is_lab: isLab,
                        location: section_data[3],
                        days: time[0],
                        start_time: time[1],
                        end_time: time[3],
                        instructor: section_data[5],
                        semester: semester.text)
        else
          Course.create(department: course_title_array[0],
                        section_number: section_data[1].strip!,
                        course_number: course_title_array[1],
                        is_lab: isLab,
                        location: section_data[3],
                        instructor: section_data[5],
                        semester: semester.text)
        end
      end
    end
  end

  #creates a new grader when one is selected for a class and updates a class to say it has a grader
  def select
    student = Student.find(params[:student_id]) 
    course = Course.find(params[:section_id])
    grader = Grader.new(course_id: params[:section_id], student_id: params[:student_id], semester: course.semester)
    grader.save
    course.have_grader = true
    course.save

    flash[:success] = "Grader was successfully chosen for CSE "+ course.course_number + "(" + course.section_number.strip + ")"
    redirect_to '/admin/dashboard'
  end

  def delete
    student = Student.find(params[:student_id]) 
    course = Course.find(params[:section_id])
    grader = Grader.find_by(course_id: params[:section_id], student_id: params[:student_id])
    grader.destroy
    if(!Grader.exists?(course_id: params[:section_id]))
      course.have_grader = false
      course.save
    end

    flash[:success] = "Grader was successfully removed from CSE "+ course.course_number + "(" + course.section_number.strip + ")"
    redirect_to '/admin/dashboard'
  end
end
