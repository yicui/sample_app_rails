class RemoveDuedateFromAssignments < ActiveRecord::Migration
  def up
    remove_column :assignments, :duedate
      end

  def down
    add_column :assignments, :duedate, :string
  end
end
