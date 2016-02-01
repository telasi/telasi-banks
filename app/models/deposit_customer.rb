class DepositCustomer < ActiveRecord::Base
  self.table_name  = Telasi::DEPOSIT_CUSTOMER_TABLE
  self.primary_key = :custkey
  self.set_integer_columns :status

  def active?; self.status == 0 end
end