class CreateExtraTimeHistories < ActiveRecord::Migration
  def change
    create_table :extra_time_histories do |t|

      t.timestamps null: false
    end
  end
end
