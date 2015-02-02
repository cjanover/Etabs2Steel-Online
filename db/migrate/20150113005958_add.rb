class Add < ActiveRecord::Migration
  def change
    add_column :model_informations, :user_id, :integer
  end
end
