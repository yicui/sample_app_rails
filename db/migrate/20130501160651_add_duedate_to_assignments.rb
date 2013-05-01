class AddDuedateToAssignments < ActiveRecord::Migration
  def change
    add_column :assignments, :duedate, :date

  end
end
