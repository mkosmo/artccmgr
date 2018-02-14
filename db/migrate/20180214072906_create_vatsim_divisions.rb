class CreateVatsimDivisions < ActiveRecord::Migration[5.2]
  def up
    create_table :vatsim_divisions, id: :uuid do |t|
      t.uuid    :region_id, null:false
      t.string  :name, null: false, unique: true
      t.string  :shortname, null: false, unique: true, :limit => 16
    end
  end
  def down
    drop_table :vatsim_divisions
  end
end
