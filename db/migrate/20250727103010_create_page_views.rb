class CreatePageViews < ActiveRecord::Migration[7.2]
  def change
    create_table :page_views do |t|
      t.string :path
      t.string :user_agent
      t.string :ip_address

      t.timestamps
    end
  end
end
