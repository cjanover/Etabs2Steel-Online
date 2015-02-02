class FixFiberOptions < ActiveRecord::Migration
  def change
    remove_column :fiber_options, :frac_bc_first, :integer
    remove_column :fiber_options, :frac_bc_second, :float
    remove_column :fiber_options, :frac_br_first, :integer
    remove_column :fiber_options, :frac_br_second, :float
  end
end
