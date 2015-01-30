class FixDefaultId < ActiveRecord::Migration
  def change
    remove_column :analysis_options, :user_id
    add_column :analysis_options, :default_id, :integer
    
    remove_column :response_time_history_options, :user_id
    add_column :response_time_history_options, :default_id, :integer
  end
end
