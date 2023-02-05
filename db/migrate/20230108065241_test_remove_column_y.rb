class TestRemoveColumnY < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :column_y, :string
    safety_assured do
      remove_column :users, :column_y, :string
    end
  end
end
