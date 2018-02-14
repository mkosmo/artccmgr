class CreateVatsimRegions < ActiveRecord::Migration[5.2]
  def up
    create_table :vatsim_regions, id: :uuid do |t|
      t.string  :name, null: false, unique: true
      t.string  :shortname, null: false, unique: true, :limit => 16
    end
  end
  def down
    drop_table :vatsim_regions
  end
end
