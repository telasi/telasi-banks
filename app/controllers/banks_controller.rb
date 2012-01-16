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
    @customers = BankCustomer.where(:bank_id => @bank.id).paginate(:page => params[:page], :per_page => 10)
  end

  # GET
  # POST
  def find_customer
    @title = "აბონენტის ძებნა"
    if request.post?
      @customer = Customer.where(:accnumb => Class.to_geo(params[:accnumb])).first
      @not_found = true unless @customer
    end
  end

  # POST
  def add_customer
    @customer = Customer.find(params[:id])
    @bank_customer = BankCustomer.where(:customer_id => @customer.id, :bank_id => @bank.id).first
    if @bank_customer
      redirect_to bank_cust_home_url, :notice => 'ეს აბონენტი უკვე არის ბაზაში'
    else
      @bank_customer = BankCustomer.new
      @bank_customer.bank = @bank
      @bank_customer.customer = @customer
      @bank_customer.save!
      redirect_to bank_cust_home_url, :notice => 'აბონენტი დამატებულია'
    end
  end

  # DELETE
  def remove_customer
    @bank_customer = BankCustomer.find(params[:id])
    @bank_customer.destroy
    redirect_to bank_cust_home_url, :notice => 'აბონენტი წაშლილია'
  end
  
  private

  # ბანკის ინიციალიზაცია გვერდის ჩატვირთვისას
  def init_bank
    @bank = Bank.find(params[:bank_id])
  end

end