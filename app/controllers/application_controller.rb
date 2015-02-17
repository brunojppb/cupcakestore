class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
<<<<<<< HEAD
  before_action :set_locale

  private 

    def set_locale
      I18n.locale = :pt
    end
=======

  include SessionsHelper
>>>>>>> user-login
end
