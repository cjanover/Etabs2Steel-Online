class CreateVerticalConstraints < ActiveRecord::Migration
  def change
    create_table :vertical_constraints do |t|

      t.timestamps null: false
    end
  end
end
