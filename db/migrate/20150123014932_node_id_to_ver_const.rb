class NodeIdToVerConst < ActiveRecord::Migration
  def change
    add_column :vertical_constraints, :node_id, :integer
  end
end
