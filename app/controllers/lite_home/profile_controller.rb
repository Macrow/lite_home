module LiteHome
  class ProfileController < ApplicationController
    before_filter :get_current_user
    skip_after_filter :register_last_activity_time_to_db, only: :destroy

    def index
    end

    def edit
    end
    
    def edit_password
    end
    
    def update_password
      if @user.update_attributes(params[:user])
        flash[:info] = t('lite_home.msg.pwd_update_succ')
        redirect_to profile_path
      else
        render action: "edit_password"
      end        
    end    
    
    def edit_avatar
    end
    
    def update_avatar
      @user.avatar = params[:avatar]
      if @user.save
        redirect_to action: 'edit_avatar'
      else
        flash.now[:error] = @user.errors.first.last
        render action: 'edit_avatar'
      end
    end

    def update
      if @user.update_attributes(params[:user])
        flash[:info] = t('lite_home.msg.info_update_succ')
        redirect_to action: 'index'
      else
        render action: 'edit'
      end
    end
    
    def confirm_destroy
    end

    def destroy
      logout
      @user.destroy
      flash[:info] = t('lite_home.msg.account_destroy')
      redirect_to root_path
    end

    private
    
    def get_current_user
      @user = current_user
    end
  end
end
