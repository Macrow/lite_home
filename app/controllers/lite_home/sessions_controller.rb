module LiteHome
  class SessionsController < ApplicationController
    skip_before_filter :require_login, :only => [:index, :new, :create]
    
    def index
      @current_users = current_users
    end
    
    def new
      if current_user
        flash[:info] = t('lite_home.msg.login_already')        
        redirect_to root_path
      end
      @user = @user_class.new
    end
  
    def create
      if @user = login(params[:user][:name], params[:user][:password], params[:user][:remember])
        @user.update_attributes!(sign_in_count: @user.sign_in_count + 1, last_sign_in_ip: request.ip)
        flash[:info] = t('lite_home.msg.login_succ')
        redirect_back_or_to root_path
      else
        flash.now[:error] = t('lite_home.msg.login_failed')
        @user = @user_class.new(params[:user])
        @user.errors.add(:name, '')
        @user.errors.add(:password, '')
        render action: 'new'
      end
    end
    
    def destroy
      logout
      flash[:info] = t('lite_home.msg.logout_succ')
      redirect_to root_path
    end
  end
end
