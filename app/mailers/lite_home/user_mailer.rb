module LiteHome
  class UserMailer < ActionMailer::Base
    default :from => LiteHome.admin_email

    def reset_password_email(user)
      @user = user
      @url  = "#{LiteHome.site_domain}/password_resets/#{user.reset_password_token}"
      mail(:to => user.email, :subject => t('lite_home.common.pwd_reset_email_title'))
    end
  end
end