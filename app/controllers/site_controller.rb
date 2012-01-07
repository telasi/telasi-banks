# encoding: utf-8
class SiteController < ApplicationController

  def index
    @title = 'საწყისი'
    @banks = Bank.all(:order => :name)
  end

  def login
    @title = 'მომხმარებლის ავტორიზაცია'
    if request.post?
      user = authenticate_from_params
      if user
        redirect_to home_url
      else
        flash[:notice] = 'არასწორი ელფოსტა ან პაროლი'
      end
    end
  end

  def logout
    session[:user_id] = nil
    redirect_to home_url
  end
end
