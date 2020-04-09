
require 'rubygems'
require 'mechanize'

# Scrape the CSE Course info page to seed the database with all the course and section information

Course.delete_all
agent = Mechanize.new

# Use mechanize to scrape the OSU CSE course information website
page = agent.get('https://web.cse.ohio-state.edu/oportal/schedule_display/')

hash_map = Hash.new

# Retrieve all the links and for each link find its id (course number) and title (course title)
links = page.css('a')
links.each do |item|
  course_number = item.attribute('href')
  course_title = item.text

  # Create a hash that maps the course number to the course title
  hash_map[course_number.to_s] = course_title
end

# Find all the rows for each table to get the information for each section of a course
# and add each section to the database
tables = page.css("tr.group0, tr.group1")
tables.each do |item|

  # Use the course id to find the title of the section's course
  course_title = hash_map["#" + item.parent.parent.parent.attribute('id')]
  course_title_array = course_title.split(" ")
  section_data = item.text.split("\n")
  time = section_data[4].split(" ")
  if(time.length() > 1) 
    puts time[0]
    puts time[1]
    puts time[3]
    # Course.new(department: course_title_array[0],
    #                 course: course_title_array[1],
    #                 component: section_data[2],
    #                 location: section_data[3],
    #                 days: time[0],
    #                 start_time: time[1],
    #                 end_time: time[3]
    #                 instructor: section_data[5])
    end

  # Course.create(number: section_data[1],
  #               title: course_title,
  #               component: section_data[2],
  #               location: section_data[3],
  #               time: section_data[4],
  #               instructor: section_data[5])
end