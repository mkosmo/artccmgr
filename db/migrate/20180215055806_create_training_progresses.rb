class CreateTrainingProgresses < ActiveRecord::Migration[5.2]
  def change
    create_table :training_progresses, id: :uuid do |t|
      t.uuid      :user_id,     null: false
      t.uuid      :block_id,    null: false
      t.datetime  :started_at,  null: false
      t.datetime  :completed_at
    end
  end
end
