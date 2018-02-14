class CreateVatsimFacilities < ActiveRecord::Migration[5.2]
  def up
    create_table :vatsim_facilities, id: :uuid do |t|
      t.uuid    :division_id, null:false
      t.string  :name, null: false, unique: true
      t.string  :short_name, null: false, unique: true, :limit => 4
    end
  end
  def down
    drop_table :vatsim_facilities
  end
end
