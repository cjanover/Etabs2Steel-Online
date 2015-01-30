class CreateVerticalConstraintOptions < ActiveRecord::Migration
  def change
    create_table :vertical_constraint_options do |t|

      t.timestamps null: false
    end
  end
end
