class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      #Log use and redirect to user page
      #later we are going to redirect the user to the last URL he tryed to access

      #using SessionsHelper module
      log_in user
      redirect_to user
    else
      #create a error message
      #using flash.now the error messages disappear as soon as there is
      #an additional request
      flash.now[:danger] = t('flash.invalid-email-password-combination')
      render 'new'
    end
  end

  def destroy
    log_out
    redirect_to root_url
  end

end
