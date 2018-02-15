class AddVatsimIdToVatsimRatings < ActiveRecord::Migration[5.2]
  def change
    add_column :vatsim_ratings, :vatsim_id, :integer, null: false, unique: true
  end
end
