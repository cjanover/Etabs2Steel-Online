class AddColumnsToModelInformation < ActiveRecord::Migration
  def change
    add_column :Model_Informations, :title, :string
    add_column :Model_Informations, :primaryetabsdir, :string
    add_column :Model_Informations, :steelsection, :string
  end
end
