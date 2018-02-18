class ChangeTrainingProgress < ActiveRecord::Migration[5.2]
  def up
    add_foreign_key :training_progresses, :users
    add_foreign_key :training_progresses, :training_blocks, column: :block_id
  end

  def down
    remove_foreign_key :training_progresses, column: :user_id
    remove_foreign_key :training_progresses, column: :block_id
  end
end
