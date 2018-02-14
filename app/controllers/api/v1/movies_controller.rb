class Api::V1::MoviesController < ApplicationController


  def index
    movies = Movie.json_data
    if movies.present?
      render json: { status: "SUCCESS", movies: movies }, status: :ok
    end
  end

  def create
    binding.pry
  end

  private

  def movies_params
    params.require(:movie).permit(:name, :director, :release_date, :image)
  end

end
