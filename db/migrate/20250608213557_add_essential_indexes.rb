class AddEssentialIndexes < ActiveRecord::Migration[7.0]
  def change
    # Posts indexes
    add_index :posts, :created_at, name: 'index_posts_on_created_at'
    add_index :posts, [ :admin_user_id, :created_at ], name: 'index_posts_on_admin_and_created_at'

    # Events indexes
    add_index :events, :created_at, name: 'index_events_on_created_at'
    add_index :events, [ :event_date, :event_time ], name: 'index_events_on_date_and_time'
    add_index :events, [ :admin_user_id, :created_at ], name: 'index_events_on_admin_and_created_at'

    # Admin users indexes
    add_index :admin_users, :created_at, name: 'index_admin_users_on_created_at'
  end
end
