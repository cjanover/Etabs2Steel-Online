class CreateNodes < ActiveRecord::Migration
  def change
    create_table :nodes do |t|
      t.integer :model_id
      t.float :X
      t.float :Y
      t.float :Z

      t.timestamps null: false
    end
  end
end
