class TeacherValidator < ActiveModel::Validator
  def validate(record)
    if Student.find_by_email(record[:email]) || Admin.find_by_email(record[:email]) 
      record.errors[:base] << "Email has already been taken"
    end
  end
end

class Teacher < ActiveRecord::Base
  has_many :courses  
  before_save { |teacher| teacher.email = email.downcase } 
  before_save :create_remember_token
  validates_presence_of :first_name, :last_name
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false}
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }
  validates_presence_of :password_confirmation  
  validates_with TeacherValidator

  private
    def create_remember_token
      self.remember_token = SecureRandom.urlsafe_base64
    end
end
