class AddPrivateToPosts < ActiveRecord::Migration[5.0]
  def change
    add_column :posts, :private, :boolean, :default => 0
  end
end
