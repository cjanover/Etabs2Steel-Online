class CreateResponseTimeHistoryOptions < ActiveRecord::Migration
  def change
    create_table :response_time_history_options do |t|

      t.timestamps null: false
    end
  end
end
