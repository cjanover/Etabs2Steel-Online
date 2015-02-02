class AddUserIdToModel < ActiveRecord::Migration
  def change
    add_column :models, :user_id, :integer
  end
end
