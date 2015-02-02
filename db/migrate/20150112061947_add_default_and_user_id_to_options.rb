class AddDefaultAndUserIdToOptions < ActiveRecord::Migration
  def change
    add_column :vertical_constraint_options, :user_id, :integer
    add_column :vertical_constraint_options, :alphavcdef, :float
  end
end
