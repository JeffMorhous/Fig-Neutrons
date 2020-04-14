class ApplicationController < ActionController::Base
  include SessionsHelper

  def convert_letter_grades_to_gpa(grade)
    if grade == 'A' then return 4.0 end
    if grade == 'A-' then return 3.7 end
    return 0
  end

  def create
    @student = Student.find_by id: session[:user_id]
    @student_name = "#{@student.first_name} #{@student.last_name}"

    index = 1
    gradeString = "grade" + index.to_s
    courseString = "courseNum" + index.to_s
    while params[gradeString] != nil
      transcript = Transcript.find_by(student_id: @student.id, course_id: params[courseString])
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
    end
    session[:user_id] = @student.id
    redirect_to '/student/profile'

  end
end
