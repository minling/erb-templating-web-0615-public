 require 'pry'
 class SiteGenerator

  def make_index!
     
      # binding.pry

    # <li><a href=\"movies/the_matrix.html\">The Matrix</a></li>
    html_top = <<-HTML
      <!DOCTYPE html>
      <html>
      <head>
        <title>Movies</title>
      </head>
      <body>
        <ul>
    HTML

     html_middle =
      Movie.all.map do |movie|
      "<li><a href=\"movies/#{movie.url}\">#{movie.title}</a></li>"
      end.join

    html_bottom = <<-HTML
</ul>
</body>
</html>
    HTML

    html_overall = "#{html_top}#{html_middle}#{html_bottom}"

    File.write("_site/index.html", html_overall)
  end
# File.read('_site/movies/the_matrix.html').gsub("\n",'').gsub(' ','')
  def generate_pages!
    reset_movies!
    make_movies!

    html = File.read('lib/templates/movie.html.erb')
    template = ERB.new(html)
    Movie.all.each do |movie|
      @movie = movie
      result = template.result(binding)
    File.write("_site/movies/#{movie.url}", result)
    end
  end


  def reset_movies!
    FileUtils.rm_rf('_site/movies')
  end

  def make_movies!
     FileUtils.mkdir_p('_site/movies')
  end

 end