class AdminValidator < ActiveModel::Validator
  def validate(record)
    if Student.find_by_email(record[:email]) || Teacher.find_by_email(record[:email])
      record.errors[:base] << "Email has already been taken"
    end
  end
end

class Admin < ActiveRecord::Base
  before_save { |admin| admin.email = email.downcase } 
  before_save :create_remember_token
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false}
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }
  validates_presence_of :password_confirmation 
  validates_with AdminValidator

  private
    def create_remember_token
      self.remember_token = SecureRandom.urlsafe_base64
    end
end
