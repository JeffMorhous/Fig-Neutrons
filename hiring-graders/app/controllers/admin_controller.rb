class AdminController < ApplicationController
  def login
    puts "admin login"
    puts params[:email]
  end
end
