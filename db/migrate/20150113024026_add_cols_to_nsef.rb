class AddColsToNsef < ActiveRecord::Migration
  def change
    add_column :nsefbc_fibers, :number, :integer
    add_column :nsefbc_fibers, :length, :float
    add_column :nsefbr_fibers, :number, :integer
    add_column :nsefbr_fibers, :length, :float
  end
end
