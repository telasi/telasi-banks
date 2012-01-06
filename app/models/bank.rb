class Bank < ActiveRecord::Base
  validates_presence_of :name
  validates_presence_of :mfo
end
