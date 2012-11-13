module LiteHome
  module Admin
    class BaseController < ::ActionController::Base
      protect_from_forgery
      layout LiteHome.layout_name
      before_filter :get_user_class
      before_filter :require_admin_login, except: [:not_authenticated]
      helper_method :current_users_list

      protected
      
      def require_admin_login
        not_authenticated unless current_user and current_user.admin
      end

      def not_authenticated
        flash[:error] = t('lite_home.msg.admin_only')
        redirect_to root_path
      end
    
      private
    
      def get_user_class
        @user_class = LiteHome::User
      end
    end
  end
end
