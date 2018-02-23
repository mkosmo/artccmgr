class CreateCalendarSchedules < ActiveRecord::Migration[5.2]
  def change
    execute <<-SQL
      CREATE TYPE day_of_week AS ENUM ('monday', 'tuesday', 'wednesday',
        'thursday', 'friday', 'saturday', 'sunday');
      CREATE TYPE month_of_year AS ENUM ('january', 'feburary', 'march',
        'april', 'may', 'june', 'july', 'august', 'september',
        'october', 'november', 'december');
    SQL

    create_table :calendar_schedules, id: :uuid do |t|
      t.integer :daily, null: true
      t.integer :monthly, null: true
      t.column  :by_day, :day_of_week, array: true, null: true

    end
  end
end
