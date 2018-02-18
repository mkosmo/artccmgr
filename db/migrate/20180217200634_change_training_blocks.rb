class ChangeTrainingBlocks < ActiveRecord::Migration[5.2]
  def up
    add_foreign_key :training_blocks, :vatsim_ratings, column: :rating_id
  end

  def down
    remove_foreign_key :training_blocks, column: :rating_id
  end
end
