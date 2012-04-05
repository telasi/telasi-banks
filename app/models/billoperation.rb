# -*- encoding : utf-8 -*-

class Billoperation < ActiveRecord::Base
  TYPE_PAYMENT = 3
  TYPE_SUBSIDY = 5
  set_table_name Telasi::BILLOPERATION_TABLE
  set_primary_key :billoperkey
  ka_accessor :billopername

  def payment?
    self.opertpkey == TYPE_PAYMENT
  end

  def subsidy?
    self.opertpkey == TYPE_SUBSIDY
  end

end
