require 'rest-client'
require  'nokogiri'
require 'launchy'
require 'sqlite3'


class HN_DB < SQLite3::Database
  include Singleton

  def initialize
    super("hn.db")

    self.results_as_hash = true
    self.type_translation = true
  end

end
# class HNClient

#   def initialize

#   end

#   def run
#     top_stories_arr = top_stories
#     print_top_stories(top_stories_arr)
#     #runs top stories
#     #takes user input
#     #gets item_url from top_stories array
#     #takes user there, etc
#   end

#   #creates a Story object for every story on the front page




#   def print_top_stories(arr)
#     arr[0..-2].each_with_index { |link, i| puts "#{i}: #{link[0]}" }
#   end

#   def open_link(link)
#     Launchy.open(link)
#   end


# end

class Story
  #add story_id
  attr_accessor :story_name, :url, :points, :user_name

  def initialize(story_name, url, points, user_name)
    @story_name, @url, @user_name, @points = story_name, url, user_name, points
    p self
  end

  def self.top_stories
    hn_homepage = Nokogiri::HTML(File.open("./hn-local-copy/index.html"))

    story_names = hn_homepage.css("td.title > a")

    points = hn_homepage.css("td.subtext > span")

    user_names = hn_homepage.css("td.subtext > a")

    story_names[0..-2].each_with_index do |story, i|
      Story.new(story.text,
        story.attr('href'),
        points[i].to_i ? points[i].children.text : nil,
        user_names[i] ? user_names[i].children.text : nil )
    end
  end
end


class User
  attr_accessor :name, :karma, :stories

  def initialize(name, karma, stories)
    @name, @karma, @stories = name, karma, stories
  end

  def self.create_user(user_name)
    profile = Nokogiri::HTML(File.open("./hn-local-copy/user?id=#{user_name}"))
    karma = profile.css('form > table tr > td')[5].text
    submitted = Nokogiri::HTML(File.open("./hn-local-copy/submitted?id=#{user_name}"))
    story_ids = submitted.css("td.subtext")
    story_ids.each_with_index do |story_id, i|
      p story_id.css("a")[1].attr('href').split('=')[1].to_i
    end
    # User.new(user_name, karma,) #story idea array

  end

end

User.create_user("MattRogish")