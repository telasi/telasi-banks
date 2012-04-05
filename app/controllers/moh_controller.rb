# -*- encoding : utf-8 -*-

class MohController < ApplicationController
  def index
    @title = 'ჯანდაცვის სამინისტროს სერვისები'
  end

  def cust
    @title = 'ინფორმაცია აბონენტზე'
    if request.post?
      @err_code, @err_msg = 0, nil
      # start date
      if @err_code == 0
        if params[:from] =~ /^([0-9]){8}$/
          @from = DateTime.strptime(params[:from], '%d%m%Y')
        else
          @err_code, @err_msg = 1, 'interval start date not defined'
        end
      end
      # end date
      if @err_code == 0
        if params[:to] =~ /^([0-9]){8}$/
          @to = DateTime.strptime(params[:to], '%d%m%Y')
        else
          @err_code, @err_msg = 2, 'interval end date not defined'
        end
      end
      # customer
      if @err_code == 0
        @customer = Customer.where(:accnumb => Class.to_geo(params[:accnumb])).first
        unless @customer
          @err_code, @err_msg = 3, 'customer not found'
        end
      end
      # getting customer info in the period
      if @err_code == 0
        @items = Item.all(:conditions => ['custkey = ? AND itemdate BETWEEN ? AND ?', @customer.custkey, @from, @to])
        @payment = @subsidy = 0
        @items.each do |item|
          if item.billoperation.payment?
            @payment += item.normilized_amount.abs
          elsif item.billoperation.subsidy?
            @subsidy += item.normilized_amount.abs
          end
        end
      end
    end
  end

end
