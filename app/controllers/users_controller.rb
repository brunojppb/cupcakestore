class UsersController < ApplicationController

  before_action :logged_in_user, only: [:index, :edit, :update]
  before_action :correct_user, only: [:edit, :update]

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    #debugger
  end

  def new
    if logged_in?
      redirect_to current_user
    else
      @user = User.new
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:info] = t('flash.welcome')
      log_in @user
      redirect_to @user
    else
      render 'new'
    end
  end

  def edit
    #correct_user(called before_action) method assign @user variable
    #I do not need to do this bellow
    #@user = User.find(params[:id])
  end

  def update
    #correct_user(called before_action) method assign @user variable
    #I do not need to do this bellow
    #@user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:info] = t('profile_update_success')
      redirect_to @user
    else
      render 'edit'
    end
  end

  private

    def user_params
      params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :phone_number)
    end


    #Before Filters
    def logged_in_user
      unless logged_in?
        #store URL that user tried to access without loggin
        store_location
        #ask to login
        flash[:danger] = t('please_log_in')
        redirect_to login_url
      end
    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end


end
