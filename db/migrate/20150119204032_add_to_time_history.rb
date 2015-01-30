class AddToTimeHistory < ActiveRecord::Migration
  def change
    add_column :extra_time_histories, :node_id, :integer
  end
end
