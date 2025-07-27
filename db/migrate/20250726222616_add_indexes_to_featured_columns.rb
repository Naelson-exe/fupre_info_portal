class AddIndexesToFeaturedColumns < ActiveRecord::Migration[7.2]
  def change
    add_index :posts, :featured
    add_index :events, :featured
  end
end
