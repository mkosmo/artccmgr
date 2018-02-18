class ChangeTrainingOtsResults < ActiveRecord::Migration[5.2]
  def up
    change_column :training_ots_results, :instructor_id, :uuid, null: true
    add_foreign_key :training_ots_results, :users, column: :instructor_id
    add_foreign_key :training_ots_results, :training_ots_recommendations, column: :recommendation_id
  end

  def down
    change_column :training_ots_results, :instructor_id, :uuid, null: true
    remove_foreign_key :training_ots_results, column: :instructor_id
    remove_foreign_key :training_ots_results, column: :recommendation_id
  end
end
