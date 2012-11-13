class CreateLiteHomeUsersTable < ActiveRecord::Migration
  def self.up
    # core
    create_table :lite_home_users do |t|
      t.string :name,               null: false  # if you use another filed as a username, for example email, you can safely remove this field.
      t.string :email,              default: nil # if you use this field as a username, you might want to make it :null => false.
      t.boolean :admin,             default: false
      t.string :crypted_password,   default: nil
      t.string :salt,               default: nil
      t.timestamps
      
      # avatar
      t.string :avatar
      
      # remember_me
      t.string :remember_me_token,                 default: nil
      t.datetime :remember_me_token_expires_at,    default: nil
      
      # reset_password
      t.string :reset_password_token,              default: nil
      t.datetime :reset_password_token_expires_at, default: nil
      t.datetime :reset_password_email_sent_at,    default: nil
      
      # brute_force_protection
      t.integer :failed_logins_count,              default: 0
      t.datetime :lock_expires_at,                 default: nil
      
      # activity_logging
      t.datetime :last_login_at,                   default: nil
      t.datetime :last_logout_at,                  default: nil
      t.datetime :last_activity_at,                default: nil
      
      # more info
      t.integer :sign_in_count,                    default: 0
      t.string :last_sign_in_ip,                   default: nil
      t.string :sex,                               default: nil
      t.string :address,                           default: nil
      t.string :im,                                default: nil
      t.string :telephone,                         default: nil
      t.string :personal_sign,                     default: nil
    end

    add_index :lite_home_users, :remember_me_token
    add_index :lite_home_users, [:last_logout_at, :last_activity_at]
    
    admin = LiteHome::User.create(name: 'admin', email: 'admin@yeah.net', password: 'admin', password_confirmation: 'admin')
    admin.admin = true
    admin.save!
  end
  
  def self.down
    drop_table :lite_home_users
  end
end