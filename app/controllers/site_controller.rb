# encoding: utf-8

class SiteController < ApplicationController

  def index
    @title = 'საწყისი'
  end

  def login
    @title = 'მომხმარებლის ავტორიზაცია'
    if request.post?
      user = authenticate_from_params
      redirect_to home_url if user
    end
  end

  def logout
    session[:user_id] = nil
    redirect_to home_url
  end
end
