class FixFiberOptions < ActiveRecord::Migration
  def change
    remove_column :Fiber_Options, :frac_bc_first, :integer
    remove_column :Fiber_Options, :frac_bc_second, :float
    remove_column :Fiber_Options, :frac_br_first, :integer
    remove_column :Fiber_Options, :frac_br_second, :float
  end
end
