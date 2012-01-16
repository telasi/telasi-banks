class BankCustomer < ActiveRecord::Base
  belongs_to :customer
  belongs_to :bank
end
