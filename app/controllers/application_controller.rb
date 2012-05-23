# -*- encoding : utf-8 -*-

class ApplicationController < ActionController::Base
  before_filter :auth_filter
  protect_from_forgery

  # რა რაოდენობის მონაცემის გამოტანაა შესძლებელი 1 გვერდზე
  MAX_PER_PAGE = 100
  # ერთ გვერდზე გამოტანის საწყისი მნიშვნელობა
  DEFAULT_PER_PAGE = 10

  # პირველ რიგში ამოწმებს მოთხოვნის პარამეტრების წყვილს:
  # <tt>auth_email</tt>, <tt>auth_password</tt>.
  # უფრო მეტი ამის შესახებ იხილეთ {authenticate_from_params}.
  #
  # თუ ავტორიზაციის პარამეტრები ვერ მოიძებნა, ან მათი
  # მეშვეობით ვერ მოხერხდა მომხმარებლის ავტორიზაცია,
  # მაშინ ეს პროცედურა ეძებს წინა ავტორიზაციას.
  #
  # თუ ვერც წინა ავტორიზაცია ვერ მოიძებნა, მაშინ პროცედურა
  # აბრუნებს <tt>nil</tt> მნიშვნელობას.
  #
  def get_current_user
    unless @__curr_user_initilized
      begin
        authenticate_from_params
        @__curr_user = User.find(session[:user_id]) if session[:user_id]
      rescue
        @__curr_user = nil  
      end
      @__curr_user_initilized = true
    end
    @__curr_user
  end

  # ცდილობს ავტორიზაციას მოთხოვნის პარამეტრებიდან გამომდინარე.
  #
  def authenticate_from_params
    email, pwd = params[:auth_email], params[:auth_password] 
    user = User.authenticate(email, pwd) if email and pwd
    session[:user_id] = user.id if user
    user
  end

  def per_page
    pp = params[:per_page] || DEFAULT_PER_PAGE
    pp = MAX_PER_PAGE if pp.to_i > MAX_PER_PAGE
    pp
  end

  private

  def need_authorize
    controller_name != 'site' and get_current_user.nil? and User.count > 0
  end

  # ავტორიზაციის ფილტრი.
  #
  def auth_filter
    
    puts "USER: #{get_current_user.nil?}"
    
    if need_authorize

      
      
#      respond_to do |format|
#        format.html { redirect_to login_url, :notice => 'გაიარეთ ავტორიზაცია' }
#        format.xml  { render :xml => '<?xml version="1.0" encoding="utf-8"?><error>Authentication required!</error>' }
#      end
    end
  end
  
end
