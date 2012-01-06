TelasiGe::Application.routes.draw do
  get '/home', :controller => :site, :action => :index, :as => :home
  match '/login', :controller => :site, :action => :login, :as => :login
  get '/logout', :controller => :site, :action => :logout, :as => :logout

  scope '/sys' do
    match '/new_user', :controller => :sysadmin, :action => :new_user, :as => :sys_new_user
    # banks
    match '/banks', :controller => :sysadmin, :action => :banks, :as => :sys_banks
    match '/new_bank', :controller => :sysadmin, :action => :new_bank, :as => :sys_new_bank
  end

  root :to => 'site#index'
end
