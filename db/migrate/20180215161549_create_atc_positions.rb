class CreateAtcPositions < ActiveRecord::Migration[5.2]
  def change
    create_table :atc_positions, id: :uuid do |t|
      t.string :name, null: false
      t.string :callsign, null: false
      t.string :callsign_prefix, null: false, limit: 3
      t.string :sector_id, limit: 3
      t.string :callsign_suffix, null: false, limit: 3
      t.decimal :frequency, null: false, default: 199.998
      t.boolean :designated, null: false, default: false
      t.boolean :primary, null: false, default: false
      t.integer :sortorder
      t.boolean :visible, null: false, default: false
    end

    add_index :atc_positions, [:visible, :sortorder]
    add_index :atc_positions, [:callsign_prefix, :callsign_suffix]
    add_index :atc_positions, [:callsign_prefix, :sector_id, :callsign_suffix], unique: true,
              :name => 'index_atc_positions_full_callsign_with_sector'
  end
end
