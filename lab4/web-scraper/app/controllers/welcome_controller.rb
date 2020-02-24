require 'rubygems'
require 'mechanize'

class WelcomeController < ApplicationController
  def index
    @courses = Course.all
  end
end