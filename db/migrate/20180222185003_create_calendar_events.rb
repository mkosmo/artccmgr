class CreateCalendarEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :calendar_events, id: :uuid do |t|
      t.string    :name, null: false
      t.timestamp :start, null: false
      t.interval  :length, null: false
    end
  end
end
