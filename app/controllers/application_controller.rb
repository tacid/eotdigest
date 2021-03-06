require "application_responder"

class ApplicationController < ActionController::Base
  self.responder = ApplicationResponder

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  include Hobo::Controller::AuthenticationSupport
  before_filter :except => [:login, :forgot_password, :accept_invitation, :do_accept_invitation, :reset_password,
:do_reset_password] do
    # Выставляем локаль согласно параметру locale
    if params[:locale]
      I18n.locale = params[:locale]
      session[:locale] = params[:locale]
    elsif session[:locale]
      I18n.locale = session[:locale]
    else
      I18n.locale = :ru
    end


    #p request
    # отмечаем активность
    logger.info("Session :user => #{session[:user]} #{current_user}");
    #User.update(current_user.id, :last_active_at => DateTime.now.utc) if logged_in?

    login_required unless User.count == 0 or
      ( !params[:reportkey].blank? and params[:id] = Report.find_by_urlkey(params[:reportkey]) )
    Thread.current[:request] = request
  end
end
