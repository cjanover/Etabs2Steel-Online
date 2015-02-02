class AddColsToFiberOptions < ActiveRecord::Migration
  def  change
    add_column :fiber_options, :frac_bc_first, :integer
    add_column :fiber_options, :frac_bc_second, :float
    add_column :fiber_options, :frac_br_first, :integer
    add_column :fiber_options, :frac_br_second, :float
  end
end
