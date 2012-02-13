# encoding: utf-8

class Street < ActiveRecord::Base
  set_table_name Telasi::STREET_TABLE
  set_primary_key :streetkey
  ka_accessor :streetname
end
