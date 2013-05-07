class Course < ActiveRecord::Base
  belongs_to :teacher  
  has_many :lecturenotes
  has_many :assignments  
  has_and_belongs_to_many :students
  validates_presence_of :number, :title, :syllabus, :teacher_id
  validates_uniqueness_of :number, message: "already exists!"
end
