class AddE2kFileToModels < ActiveRecord::Migration
  def change
    add_column :models, :e2k_file, :string
  end
end
