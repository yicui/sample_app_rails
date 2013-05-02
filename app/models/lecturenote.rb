class Lecturenote < ActiveRecord::Base
  belongs_to :course
  validates_presence_of :title, :content, :course_id  
end
