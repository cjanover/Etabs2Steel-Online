class AddIdToFiberSegements < ActiveRecord::Migration
  def change
    add_column :nsefbr_fibers, :fiber_option_id, :integer
    add_column :nsefbc_fibers, :fiber_option_id, :integer
  end
end
