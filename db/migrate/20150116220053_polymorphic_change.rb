class PolymorphicChange < ActiveRecord::Migration
  def change
    rename_column :defaults, :profile_id, :config_id
  end
end
