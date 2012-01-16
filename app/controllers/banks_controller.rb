# encoding: utf-8
class BanksController < ApplicationController
  before_filter :init_bank

  # ბანკის საწყისი გვერდი
  #
  # GET /bank-:bank_id
  def index
    @title = @bank.name
  end

  # ბანკის აბონენტების მართვის გვერდი
  #
  # GET /bank-:bank_id/cust
  def cust_index
    @title = "აბონენტების მართვა"
    @customers = BankCustomer.where(:bank_id => @bank.id)
  end

  def find_customer
    @title = "აბონენტის ძებნა"
    if request.post?
      @customer = Customer.where(:accnumb => Class.to_geo(params[:accnumb])).first
      @not_found = true unless @customer
    end
  end
  
  private

  # ბანკის ინიციალიზაცია გვერდის ჩატვირთვისას
  def init_bank
    @bank = Bank.find(params[:bank_id])
  end

end