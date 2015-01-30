class CreateModelInformations < ActiveRecord::Migration
  def change
    create_table :model_informations do |t|

      t.timestamps null: false
    end
  end
end
