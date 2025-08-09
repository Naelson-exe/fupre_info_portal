class AddSourceToPosts < ActiveRecord::Migration[7.2]
  def change
    add_column :posts, :source, :integer
  end
end
