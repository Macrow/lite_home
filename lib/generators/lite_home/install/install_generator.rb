module LiteHome
  class InstallGenerator < Rails::Generators::Base
    include Rails::Generators::Migration
    source_root File.expand_path('../templates', __FILE__)
    desc "Install LiteHome for your application."
    
    def copy_template_files
      template 'initializer.rb', 'config/initializers/lite_home.rb'
      migration_template "migration.rb", "db/migrate/create_lite_home_users_table.rb"
      copy_file "layout.html.erb", "app/views/layouts/lite_layout.html.erb"
    end
    
    def insert_js_and_css_require
      if File.exist?('app/assets/javascripts/application.js')
        insert_into_file "app/assets/javascripts/application.js", "//= require lite_home/core\n", :after => "jquery_ujs\n"
      else
        copy_file "application.js", "app/assets/javascripts/application.js"
      end
      if File.exist?('app/assets/stylesheets/application.css')
        insert_into_file "app/assets/stylesheets/application.css", " *= require lite_home/core\n", :after => "require_self\n"
      else
        copy_file "application.css", "app/assets/stylesheets/application.css"
      end
    end
    
    def insert_routes
      route("mount LiteHome::Engine => '/home', as: 'litehome_engine'")
    end
    
    
    def self.next_migration_number(dirname)
      if ActiveRecord::Base.timestamped_migrations
        Time.new.utc.strftime("%Y%m%d%H%M%S")
      else
        "%.3d" % (current_migration_number(dirname) + 1)
      end
    end
  end
end
