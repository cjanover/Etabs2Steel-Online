class AddColsToVerConstraint < ActiveRecord::Migration
  def change
    add_column :vertical_constraints, :vertical_constraint_option_id, :integer
    add_column :vertical_constraints, :x, :float
    add_column :vertical_constraints, :y, :float
    add_column :vertical_constraints, :z, :float
    add_column :vertical_constraints, :alphavc, :float
  end
end
