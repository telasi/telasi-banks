# -*- encoding : utf-8 -*-

class BankCustomer < ActiveRecord::Base
  belongs_to :customer
  belongs_to :trash_customer, :foreign_key => :customer_id
  belongs_to :bank
end
