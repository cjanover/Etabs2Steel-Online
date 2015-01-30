class CreateNsefbrFibers < ActiveRecord::Migration
  def change
    create_table :nsefbr_fibers do |t|

      t.timestamps null: false
    end
  end
end
