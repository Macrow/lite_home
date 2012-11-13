module LiteHome
  class User < ::ActiveRecord::Base
    authenticates_with_sorcery!
    mount_uploader :avatar, AvatarUploader
    attr_accessible :name, :email, :password, :password_confirmation, :lock_expires_at, :failed_logins_count, :sign_in_count, :last_sign_in_ip, :sex, :address, :im, :telephone, :personal_sign, :original_password, :remember
    attr_accessible :admin, as: :admin
    validates_presence_of :name, :email
    validates_uniqueness_of :name, :email
    validates_length_of :password, minimum: 3, if: :password
    validates_confirmation_of :password, if: :password
    validates_format_of :email, :with => /^(|(([A-Za-z0-9]+_+)|([A-Za-z0-9]+\-+)|([A-Za-z0-9]+\.+)|([A-Za-z0-9]+\++))*[A-Za-z0-9]+@((\w+\-+)|(\w+\.))*\w{1,63}\.[a-zA-Z]{2,6})$/i
    
    attr_accessor :original_password, :remember
    validate :check_original_password, if: :original_password
    def check_original_password
      errors.add(:original_password, I18n.t('lite_home.msg.origin_pwd_error')) unless User.authenticate(name, original_password)
    end
    
    scope :admins, where(admin: true)
    
    def admin?
      admin
    end

    def image
      avatar.url(:min)
    end
  end
end