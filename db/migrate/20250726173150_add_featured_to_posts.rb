class AddFeaturedToPosts < ActiveRecord::Migration[7.2]
  def change
    add_column :posts, :featured, :boolean
  end
end
