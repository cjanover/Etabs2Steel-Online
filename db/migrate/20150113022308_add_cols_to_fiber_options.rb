class AddColsToFiberOptions < ActiveRecord::Migration
  def  change
    add_column :Fiber_Options, :frac_bc_first, :integer
    add_column :Fiber_Options, :frac_bc_second, :float
    add_column :Fiber_Options, :frac_br_first, :integer
    add_column :Fiber_Options, :frac_br_second, :float
  end
end
