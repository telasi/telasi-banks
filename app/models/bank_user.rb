# -*- encoding : utf-8 -*-

class BankUser < ActiveRecord::Base
  belongs_to :user
  belongs_to :bank
end
