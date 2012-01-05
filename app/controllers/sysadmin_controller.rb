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

end
