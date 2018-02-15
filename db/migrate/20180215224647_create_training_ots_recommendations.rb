class CreateTrainingOtsRecommendations < ActiveRecord::Migration[5.2]
  def change
    create_table :training_ots_recommendations, id: :uuid do |t|
      t.references :user,       type: :uuid, index: true, null: false
      t.references :instructor, type: :uuid, index: true
      t.references :rating,     type: :uuid, index: true, null: false

      t.datetime :created_at
    end
  end
end
