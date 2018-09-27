class Movie < ActiveRecord::Base
  def self.all_ratings
    ['G', 'PG', 'PG-13', 'R']
  end
  # return movies by array of checkbox info
  def self.getMoviesByCheckBoxInfo checked
      where(:rating => checked)
  end  
end
