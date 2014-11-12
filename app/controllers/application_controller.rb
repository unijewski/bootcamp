class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_person

  before_action :set_locale

  def set_locale
    I18n.locale = params[:locale] || extract_locale_from_accept_language_header
  end

  private

  def default_url_options(options = {})
    { locale: I18n.locale }
  end

  def extract_locale_from_accept_language_header
    locales = I18n.available_locales.map(&:to_s)
    language = request.env['HTTP_ACCEPT_LANGUAGE'].scan(/^[a-z]{2}/).first if request.env['HTTP_ACCEPT_LANGUAGE']

    if locales.include?(language)
      language
    else
      I18n.default_locale
    end
  end

  def current_person
    Person.find_by(id: session[:id])
  end

  def require_logged_person
    if current_person.nil?
      session[:return_to] = request.url if request.get?
      redirect_to new_session_path, alert: 'You are not logged in!'
    end
  end

  def redirect_back_or(default)
    redirect_to(session[:return_to] || default)
    session.delete(:return_to)
  end

  def sign_in(account)
    if account
      session[:id] = account.person.id
      redirect_back_or root_path
      flash[:notice] = 'Welcome!'
    else
      flash.now[:alert] = 'Invalid email or password!'
      render 'new'
    end
  end
end
