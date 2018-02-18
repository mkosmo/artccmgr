class ChangeTrainingOtsRecommendations < ActiveRecord::Migration[5.2]
  def up
    add_foreign_key :training_ots_recommendations, :users
    add_foreign_key :training_ots_recommendations, :users, column: :instructor_id
    add_foreign_key :training_ots_recommendations, :vatsim_ratings, column: :rating_id
  end

  def down
    remove_foreign_key :training_ots_recommendations, column: :user_id
    remove_foreign_key :training_ots_recommendations, column: :instructor_id
    remove_foreign_key :training_ots_recommendations, column: :rating_id
  end
end
