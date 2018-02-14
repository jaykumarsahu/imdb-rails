class Api::V1::MoviesController < ApplicationController


  def index
    movies = Movie.json_data
    if movies.present?
      render json: { status: "SUCCESS", movies: movies }, status: :ok
    end
  end

  def create
    begin
      movie = Movie.new(movie_params)
      if movie.save
        # binding.pry
        # AttachmentWorker.perform_async(movie.id, image_params[:image])
        render json: { status: "SUCCESS" }, status: :ok
      else
        render json: { status: "FAILED", error: movie.errors.full_messages.join("\n") }, status: :ok
      end
    rescue Exception => e
      render json: { status: "FAILED", error: e.message }, status: :ok
    end
  end

  private

  def movie_params
    params.require(:movie).permit(:name, :director, :release_date, :image)
  end

  def image_params
    params.require(:movie).permit(:image)
  end

end
