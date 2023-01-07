class RemoveColumnX < ActiveRecord::Migration[7.0]
  def change
    safety_assured do
      remove_column :users, :column_x
    end
  end
end
