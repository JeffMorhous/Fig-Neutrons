# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'rubygems'
require 'mechanize'

Course.delete_all
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
sectionData = item.text.split("\n")
Course.create(number: sectionData[1],
              title: hashMap["#" + item.parent.parent.parent.attribute('id')],
              lab: sectionData[2].include?("LAB"),
              location: sectionData[3],
              time: sectionData[4],
              instructor: sectionData[5])
end