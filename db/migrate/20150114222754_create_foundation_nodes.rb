class CreateFoundationNodes < ActiveRecord::Migration
  def change
    create_table :foundation_nodes do |t|
      t.integer :foundation_node_option_id
      t.string :name
      t.float :ALP
      t.float :STRH
      t.float :STRVU
      t.float :STRVD

      t.timestamps null: false
    end
  end
end
