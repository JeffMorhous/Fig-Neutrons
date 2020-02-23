require 'rubygems'
require 'mechanize'

class WelcomeController < ApplicationController
  def index
    Course.all.each do |section|
      puts section.title
      puts section.lab
    end
  end
end
