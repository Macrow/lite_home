module LiteHome
  class PasswordResetsController < ApplicationController
    skip_before_filter :require_login
    
    def new
    end

    # request password reset.
    # you get here when the user entered his email in the reset password form and submitted it.
    def create 
      @user = @user_class.find_by_email(params[:email])
      
      if @user    
        # This line sends an email to the user with instructions on how to reset their password (a url with a random token)
        @user.deliver_reset_password_instructions!
        # Tell the user instructions have been sent whether or not email was found.
        # This is to not leak information to attackers about which emails exist in the system.
        flash[:info] = t('lite_home.msg.pwd_reset_info')
        redirect_to root_path
      else
        flash.now[:error] = t('lite_home.msg.email_not_found')
        render action: 'new'
      end
    end

    # This is the reset password form.
    def edit
      @user = @user_class.load_from_reset_password_token(params[:token])
      @token = params[:token]
      not_authenticated if !@user
    end
  
    # This action fires when the user has sent the reset password form.
    def update
      @token = params[:token] # needed to render the form again in case of error
      @user = @user_class.load_from_reset_password_token(@token)
      not_authenticated if !@user
      # the next line makes the password confirmation validation work
      @user.password_confirmation = params[:password_confirmation]
      # the next line clears the temporary token and updates the password
      if @user.change_password!(params[:password])
        flash[:info] = t('lite_home.msg.pwd_update_succ')
        redirect_to root_path
      else
        flash.now[:error] = t('lite_home.msg.wrong_email_and_pwd')
        render :action => "edit"
      end
    end

  end
end
