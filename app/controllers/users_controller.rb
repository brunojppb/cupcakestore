class UsersController < ApplicationController

  def index
  end

  def show
    @user = User.find(params[:id])
    #debugger
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
<<<<<<< HEAD
      flash[:info] = t('flash.welcome')
=======
      log_in @user
      flash[:info] = "Bem vindo a Cupcake Store!"
>>>>>>> user-login
      redirect_to @user
    else
      render 'new'
    end
  end

  private

    def user_params
      params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :phone_number)
    end


end
