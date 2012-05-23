# -*- encoding : utf-8 -*-

class BanksController < ApplicationController
  before_filter :verify_bank

  NOT_FOUND = 'NOT_FOUND'
  DUPLICATE = 'DUPLICATE'

  private

  # ბანკის ინიციალიზაცია გვერდის ჩატვირთვისას.
  # ასევე ამოწმებს აქვს თუ არა მოცემულ მომხმარებელს ამ ბანკთან მუშაობის უფლება.
  def verify_bank
    @bank = Bank.find(params[:bank_id])
    user = get_current_user
    if not user.is_sysadmin and not user.banks.include?(@bank)
      redirect_to home_url, :notice => 'არ გაქვთ ამ ბანკთან მუშაობის უფლება'
    end
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
    @customers = BankCustomer.where(:bank_id => @bank.id).paginate(page: params[:page], per_page: per_page)
    respond_to do |format|
      format.html { @title = "აბონენტების მართვა" }
      format.xml {  }
    end
  end

  # აბონენტის თვისებების ნახვა
  #
  # GET /bank-:bank_id/:id
  def cust_show
    @customer = find_bank_customer
    @title = 'აბონენტის თვისებები'
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
  private

  def find_cust
    if params[:id]
      Customer.find(params[:id])
    elsif params[:accnumb]
      Customer.where(:accnumb => params[:accnumb]).first
    end
  end

  public

  def add_customer
    @customer = find_cust
    @bank_customer = BankCustomer.where(:customer_id => @customer.id, :bank_id => @bank.id).first if @customer
    if @bank_customer
      @err_code = DUPLICATE
      @msg = "ეს აბონენტი უკვე არის თქვენს ბაზაში: #{@customer.accnumb_ka}"
    elsif @customer
      @bank_customer = BankCustomer.new
      @bank_customer.bank = @bank
      @bank_customer.customer = @customer
      @bank_customer.save!
      @err_code = nil
      @msg = "აბონენტი დამატებულია: #{@customer.accnumb_ka}"
    else
      @err_code = NOT_FOUND
      @msg = "ასეთი აბონენტი არ არსებობს: #{params[:accnumb]}"
    end
    respond_to do |format|
      format.html { redirect_to bank_cust_home_url, :notice => @msg }
      format.xml  { render :partial => 'layouts/message' }
    end
  end

  # DELETE
  def remove_customer
    @bank_customer = find_bank_customer
    if @bank_customer
      @bank_customer.destroy
      @err_code = nil
      @msg = 'აბონენტი წაშლილია'
    else
      @err_code = NOT_FOUND
      @msg = 'აბონენტი ვერ მოიძებნა'
    end
    respond_to do |format|
      format.html { redirect_to bank_cust_home_url, :notice => @msg }
      format.xml  { render :partial => 'layouts/message' }
    end
  end

  private

  def find_bank_customer
    if params[:id]
      BankCustomer.where(:id => params[:id]).first
    elsif params[:accnumb]
      cust = Customer.where(:accnumb => params[:accnumb]).first
      BankCustomer.where(:bank_id => params[:bank_id], :customer_id => cust.custkey).first if cust
    end
  end

end
