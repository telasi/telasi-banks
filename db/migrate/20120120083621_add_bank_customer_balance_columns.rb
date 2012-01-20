class AddBankCustomerBalanceColumns < ActiveRecord::Migration
  def change
    add_column :bank_customers, :balance, :decimal, :precision => 15, :scale => 2
    add_column :bank_customers, :balance_trash, :decimal, :precision => 15, :scale => 2
    add_column :bank_customers, :balance_water, :decimal, :precision => 15, :scale => 2
  end
end
