# encoding: utf-8
class SysadminController < ApplicationController

  # ადმინისტრირების საწყისი გვერდი.
  #
  # GET sys
  def index
    @title = 'ადმინისტრირება'
  end

  # მომხმარებლების გვერდი.
  #
  # GET sys/users
  def users
    @title = 'მომხმარებლები'
    @users = User.all(:order => :email)
  end

  # მომხმარებლის თვისებები.
  #
  # GET sys/user/:id
  def user
    @title = 'მომხმარებლის თვისებები'
    @user = User.find(params[:id])
  end
  
  # ახალი მომხმარებლის გახსნა.
  #
  # POST sys/users/new
  #  GET sys/users/new
  def new_user
    @title = 'ახალი მომხმარებელი'
    if request.post?
      @user = User.new(params[:user])
      redirect_to(sys_users_url, :notice => 'მომხმარებელი შექმნილია') if @user.save
    else
      @user = User.new
    end
  end

  # მომხმარებლის რედაქტირება.
  #
  # PUT sys/users/edit/:id
  # GET sys/users/edit/:id
  def edit_user
    @title = 'მომხმარებლის შეცვლა'
    @user = User.find(params[:id])
    if request.put?
      redirect_to(sys_user_url(@user), :notice => 'მომხმარებელი განახლებულია') if @user.update_attributes(params[:user])
    end
  end

  # მომხმარებლის წაშლა.
  #
  # DELETE sys/users/:id
  def destroy_user
    user = User.find(params[:id])
    unless user == get_current_user
      user.destroy
      redirect_to sys_users_url, :notice => 'მომხმარებელი წაშლილია'
    else
      redirect_to sys_users_url, :notice => 'საკუთარი თავის წაშლა დაუშვებელია!'
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
  # POST sys/banks/new
  #  GET sys/banks/new
  def new_bank
    @title = 'ახალი ბანკი'
    if request.post?
      @bank = Bank.new(params[:bank])
      redirect_to(sys_bank_url(@bank), :notice => 'ბანკი შექმნილია') if @bank.save
    else
      @bank = Bank.new
    end
  end

  # ბანკის თვისებების გამოტანა
  #
  # GET sys/bank/:id
  def bank
    @title = 'ბანკის თვისებები'
    @bank = Bank.find(params[:id])
  end

  # ბანკის თვისებების რედაქტირება.
  #
  # PUT sys/banks/edit/:id
  # GET sys/banks/edit/:id
  def edit_bank
    @title = 'ბანკის რედაქტირება'
    @bank = Bank.find(params[:id])
    if request.put?
      redirect_to(sys_bank_url(@bank), :notice => 'ბანკი შეცვლილია') if @bank.update_attributes(params[:bank])
    end
  end

  # ბანკის წაშლა.
  #
  # DELETE sys/banks/:id
  def destroy_bank
    bank = Bank.find(params[:id])
    bank.destroy
    redirect_to sys_banks_url, :notice => 'ბანკი წაშლილია'
  end

end
