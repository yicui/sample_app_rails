class Student < ActiveRecord::Base
  before_save { |student| student.email = email.downcase } 
  validates_presence_of :first_name, :last_name
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false}
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }
  validates_presence_of :password_confirmation 
end
