# encoding: utf-8

class TrashPayment < ActiveRecord::Base
  set_table_name Telasi::TRASH_PAYMENT_TABLE
  set_primary_key :paymentkey
  belongs_to :customer, :foreign_key => :custkey
  belongs_to :billoperation, :foreign_key => :operationid
  ka_accessor :billnumber
end
