class AddRememberTokenToStudents < ActiveRecord::Migration
  def change
    add_column :students, :remember_token, :string

  end
end
