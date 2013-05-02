class Assignment < ActiveRecord::Base
  belongs_to :course
  validates_presence_of :title, :description, :course_id  
end
