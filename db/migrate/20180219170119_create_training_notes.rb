class CreateTrainingNotes < ActiveRecord::Migration[5.2]
  def change
    create_table :training_notes, id: :uuid do |t|
      t.references :user,       type: :uuid, index: true, null: false
      t.references :instructor, type: :uuid, index: true
      t.references :session,    type: :uuid, index: true

      t.text :comment
      t.text :staff_comment

      t.timestamps
    end

    add_foreign_key :training_notes, :users
    add_foreign_key :training_notes, :users, column: :instructor_id
    add_foreign_key :training_notes, :training_sessions, column: :session_id
  end
end
