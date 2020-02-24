require 'rubygems'
require 'mechanize'

class WelcomeController < ApplicationController
  def index

    # Retrieve all the section information from the courses table and make it available to view
    @courses = Course.all
  end
end