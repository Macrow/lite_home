module LiteHome
  module Admin
    class UsersController < BaseController
      def index
        @user_class.per_page = LiteHome.users_per_page
        @q = @user_class.search(params[:q])
        @users = @q.result(distinct: true).order('id DESC').page(params[:page])
        @users = @users.admins if params[:admins] == 'true' 
      end
      
      def new
        @user = @user_class.new
      end
      
      def edit
        @user = @user_class.find(params[:id])
      end
      
      def create
        @user = @user_class.new(params[:user])
        if @user.save
          flash[:info] = t('lite_home.msg.create', model: t('lite_home.models.user'))
          redirect_to action: :index
        else
          render action: :new
        end
      end
      
      def update
        @user = @user_class.find(params[:id])
        if params[:user][:password] == '' and params[:user][:password_confirmation] = ''
          params[:user].delete(:password)
          params[:user].delete(:password_confirmation)
        end
        if @user.update_attributes(params[:user])
          flash[:info] = t('lite_home.msg.update', model: t('lite_home.models.user'))
          redirect_to action: :index
        else
          render action: :edit
        end
      end
      
      def destroy
        @user = @user_class.find(params[:id])
        if @user != current_user
          @user.destroy
          flash[:info] = t('lite_home.msg.destroy', model: t('lite_home.models.user'))
        else
          flash[:error] = t('lite_home.msg.can_not_destry_myself')
        end
        redirect_to action: 'index'
      end
    end
  end
end
