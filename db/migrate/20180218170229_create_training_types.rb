class CreateTrainingTypes < ActiveRecord::Migration[5.2]
  def change
    create_table :training_types, id: :uuid do |t|
      t.string :name, null: false, unique: true
    end
  end
end
