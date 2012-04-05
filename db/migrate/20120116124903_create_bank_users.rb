# -*- encoding : utf-8 -*-
class CreateBankUsers < ActiveRecord::Migration
  def change
    create_table :bank_users do |t|
      t.references :user
      t.references :bank

      t.timestamps
    end
    add_index :bank_users, :user_id
    add_index :bank_users, :bank_id
  end
end
