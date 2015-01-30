class FixNode < ActiveRecord::Migration
  def change
    remove_column :Nodes, :X
    remove_column :Nodes, :Y
    remove_column :Nodes, :Z
    add_column :Nodes, :point_name, :string
    add_column :Nodes, :floor_name, :string
  end
end
