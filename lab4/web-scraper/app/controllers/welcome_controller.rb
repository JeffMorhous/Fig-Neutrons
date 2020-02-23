require 'rubygems'
require 'mechanize'

class WelcomeController < ApplicationController
  def index
    agent = Mechanize.new
    page = agent.get('https://web.cse.ohio-state.edu/oportal/schedule_display/')
    
    hashMap = Hash.new
    links = page.css('a')
    links.each do |item| 
      courseNumber = item.attribute('href')
      courseTitle = item.text
      hashMap[courseNumber.to_s] = courseTitle
    end

    # tables = page.css("tr.group0, tr.group1")
    # tables.each do |item|
    #   sectionData = item.text.split("\n")
    #   section = Course.new
    #   section.number = sectionData[1]
    #   section.title = hashMap["#" + item.parent.parent.parent.attribute('id')]
    #   section.location = sectionData[3]
    #   section.time = sectionData[4]
    #   section.instructor = sectionData[5]
    #   section.save
    # end


    Course.all.each do |temp|
      #the code here is called once for each user
      # user is accessible by 'user' variable
      puts temp.title
    end
  end
end
