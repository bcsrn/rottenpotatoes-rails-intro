class MoviesController < ApplicationController

  def movie_params
    params.require(:movie).permit(:title, :rating, :description, :release_date)
  end

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
#    @movies = Movie.all
    @movies = Movie.order(params[:sort_by])
#    @sort_column = params[:sort_by]
    @all_ratings = Movie.all_ratings
    redirect_needed = false
    @ratings = {}
    if params[:ratings] != nil
      @ratings = params[:ratings]
      session[:ratings] = @ratings
    else 
      if session[:ratings] != nil
        @ratings = session[:ratings]
        redirect_needed = true
      end
    end
    checkedBox = @all_ratings
    
    if not @ratings.empty?
      checkedBox = @ratings.keys
    end 
 # sort condition
    if params[:condition] != nil
      condition = params[:condition]
      session[:condition] = condition 
    else
      if session[:condition] != nil
        condition = session[:condition]
        redirect_needed = true
      end
    end
    if condition == nil
      @movies = Movie.where("rating IN (?)", params[:ratings].keys)
    else
      @movies = Movie.where("rating IN (?)", params[:ratings].keys)
    end   

    # change color of table when sorting is finished
    @high_light = condition
    # clear session
    #session.clear
    
    if redirect_needed
      redirect_to movies_path(:ratings => session[:ratings], :condition => session[:condition])
    end
        
  end

  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end

end
