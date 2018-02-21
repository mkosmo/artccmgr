class DropSettings < ActiveRecord::Migration[5.2]
  def change
    drop_table :settings
  end
end
