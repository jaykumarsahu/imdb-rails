class AttachmentWorker
  include Sidekiq::Worker

  def perform(movie_id, file_or_filepath)
    movie = Movie.find(movie_id)
    if movie.present?
      attachment = get_file(file_or_filepath)
      movie.image.attach(attachment) if attachment.present?
    end
  end

  private

  def get_file(file_or_filepath)
    begin
      if file_or_filepath.instance_of? ActionDispatch::Http::UploadedFile
        return file_or_filepath
      else
        file = File.open(file_or_filepath)
        filename = file.path.split('/').last
        return {io: file, filename: filename, content_type: "image/jpg"}
      end
    rescue
      nil
    end
  end

end
