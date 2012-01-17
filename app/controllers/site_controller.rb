# encoding: utf-8
class SiteController < ApplicationController

  def index
    @title = 'საწყისი'
    user = get_current_user
    if user
      if user.is_sysadmin
        @banks = Bank.all(:order => :name)
        @show_admin = true
      else
        @banks = user.banks
        @show_admin = false
      end
    end
    
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
