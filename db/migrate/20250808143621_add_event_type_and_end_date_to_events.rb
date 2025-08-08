class AddEventTypeAndEndDateToEvents < ActiveRecord::Migration[7.2]
  def change
    rename_column :events, :event_date, :start_date
    add_column :events, :end_date, :date
    add_column :events, :event_type, :string, default: 'event', null: false
  end
end
