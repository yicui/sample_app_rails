class Course < ActiveRecord::Base
  has_many :lecturenotes
end
