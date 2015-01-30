class AddUserIdToModel < ActiveRecord::Migration
  def change
    add_column :Models, :user_id, :integer
  end
end
