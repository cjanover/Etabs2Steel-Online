class CreateFoundationNodeOptions < ActiveRecord::Migration
  def change
    create_table :foundation_node_options do |t|
      t.integer :default_id
      t.float :ALP
      t.float :STRH
      t.float :STRVU
      t.float :STRVD

      t.timestamps null: false
    end
  end
end
