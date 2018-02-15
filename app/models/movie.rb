class Movie < ApplicationRecord
  has_one_attached :image

  validates :name, :release_date, :director, presence: :true
  validate :should_be_uniq_by_name_and_release_date
  validate :validate_release_date

  scope :by_name_and_director, ->(name, director) { where(name: name.downcase, director: director.downcase) }

  before_create :downcase_fields

  def self.json_data
    self.decorate.map{ |p| p.as_json(methods: [:image_url, :name], only: :id) }
  end

  def image_url
    image.service_url if image.attached?
  end

  def build_json
    self.decorate.as_json(methods: [:image_url, :name, :release_date, :director], only: [:id])
  end

  private

  def downcase_fields
    self.name = self.name.downcase
    self.director = self.director.downcase
  end

  def should_be_uniq_by_name_and_release_date
    if Movie.by_name_and_director(name, director).exists?
      errors[:base] << "Movie should be uniqe by name and release date."
    end
  end

  def validate_release_date
    if self.release_date.blank? || self.release_date < Date.parse("01/01/1900")
      errors[:base] << "Please enter valid release date."
    end
  end
end
