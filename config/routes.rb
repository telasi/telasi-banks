TelasiGe::Application.routes.draw do
  get '/home', :controller => :site, :action => :index, :as => :home
  match '/login', :controller => :site, :action => :login, :as => :login
  get '/logout', :controller => :site, :action => :logout, :as => :logout

  # ადმინისტრირების პროგრამა
  scope '/sys' do
    get '/', :controller => :sysadmin, :action => :index, :as => :sys
    # users
    scope 'users' do
      get '/', :controller => :sysadmin, :action => :users, :as => :sys_users
      match 'new', :controller => :sysadmin, :action => :new_user, :as => :sys_new_user
      get '/:id', :controller => :sysadmin, :action => :user, :as => :sys_user
      delete '/:id', :controller => :sysadmin, :action => :destroy_user, :as => :sys_destroy_user
      match '/edit/:id', :controller => :sysadmin, :action => :edit_user, :as => :sys_edit_user
    end
    # banks
    scope '/banks' do
      match '/', :controller => :sysadmin, :action => :banks, :as => :sys_banks
      match '/new', :controller => :sysadmin, :action => :new_bank, :as => :sys_new_bank
      get '/:id', :controller => :sysadmin, :action => :bank, :as => :sys_bank
      delete '/:id', :controller => :sysadmin, :action => :destroy_bank, :as => :sys_destroy_bank
      match '/edit/:id', :controller => :sysadmin, :action => :edit_bank, :as => :sys_edit_bank
      match '/add_user/:id', :controller => :sysadmin, :action => :add_bankuser, :as => :sys_add_bankuser
      delete '/remove_user/:bank_id/:user_id', :controller => :sysadmin, :action => :remove_bankuser, :as => :sys_remove_bankuser
    end
  end

  # ბანკის სერვისები
  scope '/bank-:bank_id' do
    get '/', :controller => :banks, :action => :index, :as => :bank_home
    scope 'cust' do
      get '/', :controller => :banks, :action => :cust_index, :as => :bank_cust_home
      match '/find', :controller => :banks, :action => :find_customer, :as => :bank_find_customer
      post '/add/:id', :controller => :banks, :action => :add_customer, :as => :bank_add_customer
      delete '/remove/:id', :controller => :banks, :action => :remove_customer, :as => :bank_remove_customer
    end
  end

  root :to => 'site#index'
end
