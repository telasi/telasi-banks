# encoding: utf-8
class MohController < ApplicationController

  def index
    @title = 'ჯანდაცვის სამინისტროს სერვისები'
  end

  def cust
    @title = 'ინფორმაცია აბონენტზე'
  end
  
end
