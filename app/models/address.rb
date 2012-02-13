# encoding: utf-8

class Address < ActiveRecord::Base
  set_table_name Telasi::ADDRESS_TABLE
  set_primary_key :premisekey
  belongs_to :street, :foreign_key => :streetkey
  ka_accessor :house, :building, :porch, :flate, :postindex

  def to_s
    a = ''
    a += "#{self.postindex_ka.strip} " if self.postindex and not self.postindex.strip.empty?
    a += self.street.streetname_ka.strip
    a += " №#{self.building_ka.strip}" if self.building and not self.building.strip.empty?
    a += " #{self.house_ka.strip}" if self.house and not self.house.strip.empty?
    a += ", სად. #{self.porch_ka.strip}" if self.porch and not self.porch.strip.empty?
    a += ", ბ. #{self.flate_ka.strip}" if self.flate and not self.flate.strip.empty?
    a
  end
end
