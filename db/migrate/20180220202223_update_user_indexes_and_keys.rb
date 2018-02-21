class UpdateUserIndexesAndKeys < ActiveRecord::Migration[5.2]
  def change
    remove_index :users, :email
    add_index :users, :email, unique: false

    add_foreign_key :users, :vatsim_ratings,    column: :rating_id
    add_foreign_key :users, :vatsim_facilities, column: :facility_id
  end
end
