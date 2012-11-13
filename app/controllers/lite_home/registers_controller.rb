module LiteHome
  class RegistersController < ApplicationController
    skip_before_filter :require_login
    def new
      @user = @user_class.new
    end

    def create
      @user = @user_class.new(params[LiteHome.user_class.downcase.to_sym])
      if @user.save
        login(@user.name, params[LiteHome.user_class.downcase.to_sym][:password])
        @user.update_attributes!(sign_in_count: @user.sign_in_count + 1, last_sign_in_ip: request.ip)
        flash[:info] = t('lite_home.msg.register_ok')
        redirect_to root_path
      else
        render :action => "new"
      end
    end
  end
end
