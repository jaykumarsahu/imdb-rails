class Api::V1::MoviesController < ApplicationController
  before_action :init_movie, only: :show

  def index
    movies = Movie.json_data
    if movies.present?
      render json: { status: "SUCCESS", movies: movies }, status: :ok
    end
  end

  def show
    if @movie.present?
      render json: { status: "SUCCESS", movie: @movie.build_json}, status: :ok
    else
      render json: { status: "FAILED", error: "Movie not found." }, status: :ok
    end
  end

  def create
    begin
      movie = Movie.new(movie_params)
      if movie.save
        movie.image.attach(image_params[:image]) if image_params[:image].present?
        render json: { status: "SUCCESS", movie: movie.build_json }, status: :ok
      else
        render json: { status: "FAILED", error: movie.errors.full_messages.join("\n") }, status: :ok
      end
    rescue Exception => e
      render json: { status: "FAILED", error: e.message }, status: :ok
    end
  end

  private

  def init_movie
    @movie =  Movie.find_by(id: params[:id])
  end

  def movie_params
    params.require(:movie).permit(:name, :director, :release_date)
  end

  def image_params
    params.require(:movie).permit(:image)
  end

end
