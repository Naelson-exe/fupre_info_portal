class AddPostTypeAndSeverityToPosts < ActiveRecord::Migration[7.2]
  def change
    add_column :posts, :post_type, :integer
    add_column :posts, :severity, :integer
  end
end
