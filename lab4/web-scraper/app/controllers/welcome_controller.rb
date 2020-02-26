require 'rubygems'
require 'mechanize'

# This file is the controller that handles initial page load and retrieving the CSE course data

class WelcomeController < ApplicationController
  def index

    # Retrieve all the section information from the courses table and make it available to view
    @courses = Course.all
  end
end