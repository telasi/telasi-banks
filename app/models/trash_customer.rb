# -*- encoding : utf-8 -*-

class TrashCustomer < ActiveRecord::Base
  set_table_name Telasi::TRASH_CUSTOMERS_TABLE
  set_primary_key :custkey
end
