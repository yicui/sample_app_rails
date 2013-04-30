class Course < ActiveRecord::Base
  has_many :lecturenotes
  has_many :assignments  
end
