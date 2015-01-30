class CreateNsefbcFibers < ActiveRecord::Migration
  def change
    create_table :nsefbc_fibers do |t|

      t.timestamps null: false
    end
  end
end
