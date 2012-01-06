# encoding: utf-8
class SysadminController < ApplicationController

  # ახალი მომხმარებლის გახსნა.
  #
  # POST sys/new_user
  #  GET sys/new_user
  def new_user
    @title = 'ახალი მომხმარებელი'
    if request.post?
      @user = User.new(params[:user])
      redirect_to(home_url, :notice => 'მომხმარებელი შექმნილია') if @user.save
    else
      @user = User.new
    end
  end

  # ბანკების სიის გამოტანა.
  #
  #  GET sys/banks
  def banks
    @title = 'ბანკები'
    @banks = Bank.all(:order => :name)
  end

  # ახალი ბანკის გახსნა.
  #
  # POST sys/new_bank
  #  GET sys/new_bank
  def new_bank
    @title = 'ახალი ბანკი'
    if request.post?
      @bank = Bank.new(params[:bank])
      redirect_to(sys_banks_url, :notice => 'ბანკი შექმნილია') if @bank.save
    else
      @bank = Bank.new
    end
  end

  # ბანკის თვისებების რედაქტირება.
  #
  # PUT sys/edit_bank/:id
  # GET sys/edit_bank/:id
  def edit_bank
    @title = 'ბანკის რედაქტირება'
    @bank = Bank.find(params[:id])
    if request.put?
      redirect_to(sys_banks_url, :notice => 'ბანკი შეცვლილია') if @bank.update_attributes(params[:bank])
    end
  end
  
end
