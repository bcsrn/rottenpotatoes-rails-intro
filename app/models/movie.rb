class Movie < ActiveRecord::Base

  #static method to get rating enumeration
  def self.all_ratings
    ['G', 'PG', 'PG-13', 'R']
  end 
  # return movies by array of checkbox info
  def self.getMoviesByCheckBoxInfo checked
    condition = 'rating='
    checked.each do |elt|
      condition = condition + elt.to_s
    end
  end
end
