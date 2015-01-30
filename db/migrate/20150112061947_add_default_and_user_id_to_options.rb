class AddDefaultAndUserIdToOptions < ActiveRecord::Migration
  def change
    add_column :Vertical_Constraint_Options, :user_id, :integer
    add_column :Vertical_Constraint_Options, :alphavcdef, :float
  end
end
