class AddIsPendingToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :is_pending, :boolean, default: true
  end
end
