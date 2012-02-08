class AddMinistryOfHealthFlagToUser < ActiveRecord::Migration
  def change
    add_column :users, :is_moh, :boolean
  end
end
