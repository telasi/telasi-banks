# -*- encoding : utf-8 -*-

class Bank < ActiveRecord::Base
  validates_presence_of :name
  validates_presence_of :mfo
  has_many :bank_users
  has_many :users, :through => :bank_users
  def to_s
    self.name
  end
end
