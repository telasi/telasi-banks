class Customer < ActiveRecord::Base
  set_table_name Telasi::CUSTOMERS_TABLE
  set_primary_key :custkey
end
