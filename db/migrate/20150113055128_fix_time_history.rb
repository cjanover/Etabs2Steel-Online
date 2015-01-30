class FixTimeHistory < ActiveRecord::Migration
  def change
    add_column :response_time_history_options, :user_id, :integer
    add_column :response_time_history_options, :plotall, :boolean
    add_column :response_time_history_options, :plotsecondary, :boolean
    
    add_column :extra_time_histories, :response_time_history_option_id, :integer
    add_column :extra_time_histories, :x1, :float
    add_column :extra_time_histories, :y1, :float
    add_column :extra_time_histories, :z1, :float
    add_column :extra_time_histories, :x2, :float
    add_column :extra_time_histories, :y2, :float
    add_column :extra_time_histories, :z2, :float
    add_column :extra_time_histories, :outputtype, :integer
    add_column :extra_time_histories, :outputvalue, :integer
  end
end
