class CreateEvents < ActiveRecord::Migration[7.0]
  def change
    create_table :events do |t|
      t.string :title, null: false
      t.text :description
      t.datetime :start_time, null: false
      t.datetime :end_time
      t.string :location
      t.string :status, null: false, default: 'upcoming'
      t.references :admin_user, null: false, foreign_key: true
      t.timestamps
    end

    add_index :events, :title
    add_index :events, :start_time
    add_index :events, :status
  end
end
