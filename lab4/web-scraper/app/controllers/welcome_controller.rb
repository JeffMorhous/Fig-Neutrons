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

    tables = page.css("tr.group0, tr.group1")
    tables.each do |item|
      puts "Course Title:" + hashMap["#" + item.parent.parent.parent.attribute('id')]
      sectionData = item.text.split("\n")
      puts "Class number: " + sectionData[1]
      puts "Component: " + sectionData[2]
      puts "Location: " + sectionData[3]
      puts "Times: " + sectionData[4]
      puts "Instructor: " + sectionData[5]
      puts "Session: " + sectionData[6]
      puts "\n"
    end
  end
end
