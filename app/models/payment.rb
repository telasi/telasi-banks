# -*- encoding : utf-8 -*-

class Payment < ActiveRecord::Base
  set_table_name Telasi::PAYMENT_TABLE
  set_primary_key :paymentkey
  belongs_to :customer, :foreign_key => :custkey
  belongs_to :billoperation, :foreign_key => :billoperkey
  ka_accessor :billnumber
end
