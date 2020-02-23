require 'rubygems'
require 'mechanize'

class WelcomeController < ApplicationController
  def index
    Course.all.each do |section|
      puts section.title
      puts section.component
    end
  end
end