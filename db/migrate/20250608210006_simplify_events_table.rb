class SimplifyEventsTable < ActiveRecord::Migration[7.0]
  def up
    # Remove complex scheduling fields
    remove_column :events, :status, :integer
    remove_column :events, :start_time, :datetime
    remove_column :events, :end_time, :datetime
    remove_column :events, :location, :string
    remove_column :events, :published_at, :datetime

    # Add calendar-specific fields
    add_column :events, :event_date, :date, null: false
    add_column :events, :event_time, :time

    # Rename description to details for better clarity
    rename_column :events, :description, :details

    # Add index for date-based queries
    add_index :events, :event_date
  end

  def down
    # Remove new calendar fields
    remove_column :events, :event_date, :date
    remove_column :events, :event_time, :time

    # Remove index
    remove_index :events, :event_date

    # Restore original fields
    add_column :events, :status, :integer
    add_column :events, :start_time, :datetime
    add_column :events, :end_time, :datetime
    add_column :events, :location, :string
    add_column :events, :published_at, :datetime

    # Rename details back to description
    rename_column :events, :details, :description
  end
end
