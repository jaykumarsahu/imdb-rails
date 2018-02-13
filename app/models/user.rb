class User < ApplicationRecord
  has_secure_password

  validates :email, uniqueness: true
  validates :first_name, :last_name, length: { minimum: 1, maximum: 50 }

end
