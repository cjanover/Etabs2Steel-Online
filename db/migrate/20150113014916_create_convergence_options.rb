class CreateConvergenceOptions < ActiveRecord::Migration
  def change
    create_table :convergence_options do |t|
      t.integer :user_id
      t.float :eec
      t.integer :nsefbc
      t.integer :nsefbr
      t.integer :milf

      t.timestamps null: false
    end
  end
end
