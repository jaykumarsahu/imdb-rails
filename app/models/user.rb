class User < ApplicationRecord
  has_secure_password

  validates :email, uniqueness: true
  validates :first_name, :last_name, length: { minimum: 1, maximum: 50 }
  before_validation :dowmcase_fields

  def build_json
    self.decorate.as_json(
                            only: [:id, :admin, :email, :phone, :zip],
                            methods: [:first_name, :last_name, :address, :city, :state, :country]
                         )
  end

  private

  def dowmcase_fields
    %w(first_name last_name email address city state country).each do |field_name|
      self[field_name] = eval("self.#{field_name}.downcase")
    end
  end

end
