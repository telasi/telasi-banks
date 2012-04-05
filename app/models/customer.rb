# -*- encoding : utf-8 -*-

class Customer < ActiveRecord::Base
  set_table_name Telasi::CUSTOMERS_TABLE
  set_primary_key :custkey
  ka_accessor :custname, :accnumb
  has_one :address, :foreign_key => :premisekey
end
