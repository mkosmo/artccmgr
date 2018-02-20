class CreateSettings < ActiveRecord::Migration[5.2]
  def change
    create_table :settings, id: :uuid do |t|
      t.string :key, index: true, unique: true, null: false
      t.jsonb  :value, null: false, default: '{}'
    end
  end
end
