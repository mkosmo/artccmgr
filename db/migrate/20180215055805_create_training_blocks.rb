class CreateTrainingBlocks < ActiveRecord::Migration[5.2]
  def change
    create_table :training_blocks, id: :uuid do |t|
      t.uuid    :rating_id
      t.string  :name,        null: false
      t.text    :description
      t.integer :order,       null: false
    end
  end
end
