module LiteHome
  class UsersController < ApplicationController
    skip_before_filter :require_login
    
    def show
      @user = @user_class.find_by_name(params[:name])
      if @user.nil?
        flash[:error] = t('lite_home.msg.user_not_found')
        redirect_to root_path
      end
    end
  end
end
