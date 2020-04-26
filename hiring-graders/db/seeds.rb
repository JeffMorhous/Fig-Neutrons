
require 'rubygems'
require 'mechanize'

# Scrape the CSE Course info page to seed the database with all the course and section information

Course.delete_all
agent = Mechanize.new

# Use mechanize to scrape the OSU CSE course information website
page = agent.get('https://web.cse.ohio-state.edu/oportal/schedule_display/')
form = page.form_with(:dom_id => 'filter')
form.field_with(:name => 'strm').options.each do |semester|
  semester.click
  semester_page = form.submit.parser
  hash_map = Hash.new

  # Retrieve all the links and for each link find its id (course number) and title (course title)
  links = semester_page.css('a')
  links.each do |item|
    course_number = item.attribute('href')
    course_title = item.text

    # Create a hash that maps the course number to the course title
    hash_map[course_number.to_s] = course_title
  end

  # Find all the rows for each table to get the information for each section of a course
  # and add each section to the database
  tables = semester_page.css("tr.group0, tr.group1")
  tables.each do |item|
    
    # Use the course id to find the title of the section's course
    course_title = hash_map["#" + item.parent.parent.parent.attribute('id')]
    course_title_array = course_title.split(" ")
    section_data = item.text.split("\n")
    time = section_data[4].split(" ")
    isLab = section_data[2].include? "LAB"
    if time.length > 1
      Course.create(department: course_title_array[0],
                    section_number: section_data[1].strip!,
                    course_number: course_title_array[1],
                    is_lab: isLab,
                    location: section_data[3],
                    days: time[0],
                    start_time: time[1],
                    end_time: time[3],
                    instructor: section_data[5],
                    semester: semester.text)
    else
      Course.create(department: course_title_array[0],
                    section_number: section_data[1].strip!,
                    course_number: course_title_array[1],
                    is_lab: isLab,
                    location: section_data[3],
                    instructor: section_data[5],
                    semester: semester.text)
    end
  end
end