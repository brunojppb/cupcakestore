class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :set_locale

  include SessionsHelper

  private
    def set_locale
      if logged_in?
        I18n.default_locale = current_user.language
      else
        I18n.default_locale = :pt
      end
    end
    
end
