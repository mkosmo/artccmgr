class CreateTrainingOtsResults < ActiveRecord::Migration[5.2]
  def change
    create_table :training_ots_results, id: :uuid do |t|
      t.references :recommendation, type: :uuid, index: true, null: false, unique: true
      t.references :instructor, type: :uuid, index: true, null: false
      t.boolean    :pass,     default: false
      t.text       :comments, null: false

      t.datetime :created_at
    end
  end
end
