class CreatePosts < ActiveRecord::Migration[7.0]
  def change
    create_table :posts do |t|
      t.string :title, null: false
      t.text :summary
      t.text :content, null: false
      t.string :status, null: false, default: 'draft'
      t.references :admin_user, null: false, foreign_key: true
      t.timestamps
    end

    add_index :posts, :title
    add_index :posts, :status
  end
end
