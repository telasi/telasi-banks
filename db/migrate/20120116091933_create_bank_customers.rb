# -*- encoding : utf-8 -*-
class CreateBankCustomers < ActiveRecord::Migration
  def change
    create_table :bank_customers do |t|
      t.references :customer
      t.references :bank
      t.timestamps
    end
    add_index :bank_customers, :bank_id
  end
end
