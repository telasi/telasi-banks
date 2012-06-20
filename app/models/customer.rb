# -*- encoding : utf-8 -*-

class Customer < ActiveRecord::Base

  set_table_name Telasi::CUSTOMERS_TABLE
  set_primary_key :custkey
  ka_accessor :custname, :accnumb
  has_one  :address, foreign_key: :premisekey
  has_many :pre_payments, class_name: 'Payment', foreign_key: :custkey, conditions: {status: [0,1]}
  has_many :pre_trash_payments, class_name: 'TrashPayment', foreign_key: :custkey, conditions: {status: [0,1]}

  def pre_payment
    self.pre_payments.inject(0) do |sum, payment|
      sum += (payment.paydate > Date.today - 7) ? payment.amount : 0
    end
  end

  def pre_trash_payment
    self.pre_trash_payments.inject(0) do |sum, payment|
      sum += (payment.paydate > Date.today - 7) ? payment.amount : 0
    end
  end

end
