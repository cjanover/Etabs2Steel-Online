class AddToTimeHistory2 < ActiveRecord::Migration
  def change
    add_column :extra_time_histories, :node2_id, :integer
  end
end
