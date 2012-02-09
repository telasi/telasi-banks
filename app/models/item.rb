# encoding: utf-8

class Item < ActiveRecord::Base
  set_table_name Telasi::ITEM_TABLE
  set_primary_key :itemkey
  ka_accessor :itemnumbers
  belongs_to :customer, :foreign_key => :custkey
  belongs_to :billoperation, :foreign_key => :billoperkey

  def normilized_amount
    if self.billoperation.subsidy?
      - self.amount.abs
    elsif self.billoperation.payment?
      - self.amount
    else
      self.amount
    end
  end

end
