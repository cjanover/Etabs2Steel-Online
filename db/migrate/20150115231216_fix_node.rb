class FixNode < ActiveRecord::Migration
  def change
    remove_column :nodes, :X
    remove_column :nodes, :Y
    remove_column :nodes, :Z
    add_column :nodes, :point_name, :string
    add_column :nodes, :floor_name, :string
  end
end
