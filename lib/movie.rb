require 'pry'
class Movie
  attr_accessor :title, :release_date, :director, :summary

  @@all = []
  def initialize(title, release_date, director, summary)
    @title = title
    @release_date = release_date
    @director = director
    @summary = summary
    @@all << self
  end

  def url
    "#{@title.downcase.split(' ').join('_')}.html"
  end

  def self.all
    @@all
  end

  def self.reset_movies!
    self.all.clear
  end

  def self.make_movies!
    File.open('spec/fixtures/movies.txt').each_line do |line|
      movie_file = line.chomp.split("\t")

        title = movie_file.first.split("-").first.strip
        director = movie_file.first.split("-")[2].strip
        release_date = movie_file.first.split("-")[1].strip.to_i
        summary = movie_file.first.split("-")[3].strip

    Movie.new(title,release_date, director, summary)
    end
  end

  def self.recent
    self.all.select do |movie|
      movie.release_date >= 2012
    end

  end

end