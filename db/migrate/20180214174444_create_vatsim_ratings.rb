class CreateVatsimRatings < ActiveRecord::Migration[5.2]
  def change
    create_table :vatsim_ratings, id: :uuid do |t|
      t.string :name,       null: false, unique: true
      t.string :short_name, null: false, limit: 3, unique: true
    end
  end
end
