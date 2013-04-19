class CreateLecturenotes < ActiveRecord::Migration
  def change
    create_table :lecturenotes do |t|
      t.string :title
      t.string :content
      t.integer :course_id

      t.timestamps
    end
  end
end
