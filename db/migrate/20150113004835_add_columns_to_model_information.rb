class AddColumnsToModelInformation < ActiveRecord::Migration
  def change
    add_column :model_informations, :title, :string
    add_column :model_informations, :primaryetabsdir, :string
    add_column :model_informations, :steelsection, :string
  end
end
