class TestRemoveColumnY < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :column_y, :string
    remove_column :users, :column_y, :string
  end
end
