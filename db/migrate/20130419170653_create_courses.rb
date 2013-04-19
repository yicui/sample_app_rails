class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.string :title
      t.string :description
      t.string :syllabus
      t.integer :teacher_id

      t.timestamps
    end
  end
end
