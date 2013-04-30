class Course < ActiveRecord::Base
  belongs_to :teacher  
  has_many :lecturenotes
  has_many :assignments  
end
