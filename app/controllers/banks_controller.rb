# encoding: utf-8
class BanksController < ApplicationController

  def index
    @bank = Bank.find(params[:bank_id])
    @title = @bank.name
  end

end