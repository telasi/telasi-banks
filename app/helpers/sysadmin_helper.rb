# encoding: utf-8

module SysadminHelper

  def number_format(num, prec = 2)
    number_with_precision(num, :precision => prec, :delimiter => ',', :separator => '.')
  end

end
