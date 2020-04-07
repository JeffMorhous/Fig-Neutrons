class StudentController < ApplicationController
  def create
    puts "create student"
    puts params[:fName]
    puts params[:lName]
    puts params[:email]
  end
  
  def login
    puts "student login"
    puts params[:email]
  end

  def application
  end


end
