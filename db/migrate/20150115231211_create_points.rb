class CreatePoints < ActiveRecord::Migration
  def change
    create_table :points do |t|
      t.integer :model_id
      t.string :name
      t.float :X
      t.float :Y

      t.timestamps null: false
    end
  end
end
