module LiteHome
  class ApplicationController < ActionController::Base
    protect_from_forgery
    layout LiteHome.layout_name
    before_filter :get_user_class
    before_filter :require_login, :except => [:not_authenticated]
    helper_method :current_users_list

    protected

    def not_authenticated
      flash[:info] = t('lite_home.msg.require_login')
      redirect_to login_path
    end
    
    private
    
    def get_user_class
      @user_class = LiteHome::User
    end
  end
end
