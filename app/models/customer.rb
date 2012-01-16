class Customer < ActiveRecord::Base
  set_table_name Telasi::CUSTOMERS_TABLE
  set_primary_key :custkey

  ka_accessor :custname, :accnumb
  
#  def custname_ka
#    Telasi.to_ka(self.custname)
#  end
#
#  def custname_ka=(name)
#    self.custname = Telasi.to_geo(name)
#  end

end
