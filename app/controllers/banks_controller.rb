# encoding: utf-8
class BanksController < ApplicationController
  before_filter :verify_bank

  private

  # ბანკის ინიციალიზაცია გვერდის ჩატვირთვისას.
  # ასევე ამოწმებს აქვს თუ არა მოცემულ მომხმარებელს ამ ბანკთან მუშაობის უფლება.
  def verify_bank
    @bank = Bank.find(params[:bank_id])
    user = get_current_user
    redirect_to home_url, :notice => 'არ გაქვთ ამ ბანკთან მუშაობის უფლება' unless user.banks.include?(@bank)
  end

  public

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
    @customers = BankCustomer.where(:bank_id => @bank.id).paginate(:page => params[:page], :per_page => per_page)
    respond_to do |format|
      format.html { @title = "აბონენტების მართვა" }
      format.xml {  }
    end
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

end