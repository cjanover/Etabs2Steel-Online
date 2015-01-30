class PolymorphicChange2 < ActiveRecord::Migration
  def change
    add_column :defaults, :config_type, :string
  end
end
