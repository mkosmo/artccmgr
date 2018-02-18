class CreateTrainingSessions < ActiveRecord::Migration[5.2]
  def change
    create_table :training_sessions, id: :uuid do |t|
      t.references :user,       type: :uuid, index: true, null: false
      t.references :instructor, type: :uuid, index: true
      t.references :type,       type: :uuid, index: true

      t.datetime :started_at, null: false
      t.datetime :ended_at,   null: false
    end

    add_column    :training_progresses, :session_id, :uuid, null: false, index: true

    add_foreign_key :training_progresses, :training_sessions, column: :session_id

    remove_column :training_ots_results, :comments, :text, null: false
    add_column    :training_ots_results, :session_id, :uuid, null: false, index: true

    add_foreign_key :training_ots_results, :training_sessions, column: :session_id

    add_foreign_key :training_sessions, :users
    add_foreign_key :training_sessions, :users, column: :instructor_id
    add_foreign_key :training_sessions, :training_types, column: :type_id
  end
end
