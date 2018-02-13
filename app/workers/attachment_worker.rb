class AttachmentWorker
  include Sidekiq::Worker

  def perform(movie_id, filepath)
    movie = Movie.find(movie_id)
    if movie.present?
      file = File.open(filepath)
      filename = file.path.split('/').last
      attachment = {io: file, filename: filename, content_type: "image/jpg"}
      movie.image.attach attachment
    end
  end
end
