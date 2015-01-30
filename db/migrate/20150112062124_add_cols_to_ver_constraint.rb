class AddColsToVerConstraint < ActiveRecord::Migration
  def change
    add_column :Vertical_Constraints, :vertical_constraint_option_id, :integer
    add_column :Vertical_Constraints, :x, :float
    add_column :Vertical_Constraints, :y, :float
    add_column :Vertical_Constraints, :z, :float
    add_column :Vertical_Constraints, :alphavc, :float
  end
end
