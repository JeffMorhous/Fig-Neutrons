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

    @num = params.size
    transcript = Transcript.find_by(student_id: @student.id, course_id: params[:courseNum1])
    if transcript != nil
      transcript.grade = convert_letter_grades_to_gpa(params[:grade1])
      transcript.updated_at = Time.new
    else
      transcript = Transcript.new(
          grade: convert_letter_grades_to_gpa(params[:grade1]),
          created_at: Time.new,
          updated_at: Time.new,
          student_id: @student.id,
          course_id: params[:courseNum1])
    end
    if transcript.save
      session[:user_id] = @student.id
      redirect_to '/student/profile'
    end
  end
end
