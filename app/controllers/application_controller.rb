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

  before_action :set_locale

  include SessionsHelper
<<<<<<< HEAD
>>>>>>> user-login
=======


  private
    def set_locale
      if logged_in?
        I18n.default_locale = current_user.language
      else
        I18n.default_locale = :pt
      end
    end
>>>>>>> user-login
end
