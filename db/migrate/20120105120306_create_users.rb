# -*- encoding : utf-8 -*-
class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email
      t.string :mobile
      t.string :first_name
      t.string :last_name
      t.string :salt
      t.string :hashed_password
      t.boolean :is_sysadmin
      t.boolean :is_internal

      t.timestamps
    end
    add_index :users, :email
  end
end
