class AddSenderDetailsToPosts < ActiveRecord::Migration[7.2]
  def change
    add_column :posts, :sender_name, :string
    add_column :posts, :sender_title, :string
  end
end
