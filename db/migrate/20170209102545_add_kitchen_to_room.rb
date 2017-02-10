class AddKitchenToRoom < ActiveRecord::Migration
  def change
    add_column :rooms, :is_kitchen, :boolean
  end
end
