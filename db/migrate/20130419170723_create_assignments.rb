class CreateAssignments < ActiveRecord::Migration
  def change
    create_table :assignments do |t|
      t.string :title
      t.string :description
      t.string :duedate
      t.integer :course_id

      t.timestamps
    end
  end
end
