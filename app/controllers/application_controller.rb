# encoding: utf-8
class ApplicationController < ActionController::Base
  protect_from_forgery

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

end
