class Add < ActiveRecord::Migration
  def change
    add_column :Model_Informations, :user_id, :integer
  end
end
