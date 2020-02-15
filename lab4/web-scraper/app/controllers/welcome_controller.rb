require 'rubygems'
require 'mechanize'

class WelcomeController < ApplicationController
  def index
    agent = Mechanize.new
    page = agent.get('https://web.cse.ohio-state.edu/oportal/schedule_display/')
    page.links.each do |link|
      puts link.text
    end
  end
end
