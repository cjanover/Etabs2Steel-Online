class CreateAnalyses < ActiveRecord::Migration
  def change
    create_table :analyses do |t|
      t.integer :model_id
      t.string :name

      t.timestamps null: false
    end
  end
end
