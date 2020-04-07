class InstructorController < ApplicationController
  def create
    puts "create instructor"
    puts params[:fName]
    puts params[:lName]
    puts params[:email]

  end
  
  def login
    puts "login instructor"
    puts params[:email]
  end

  def recommendation
  end
  

end
