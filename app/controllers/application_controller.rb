class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :require_user

  # makes these methdos available even to views
  helper_method :current_user, :logged_in?

  def current_user
    # memoisation - doesn't call to db if no @current_user object
    @current_user ||= Student.find(session[:student_id]) if session[:student_id]
  end

  def logged_in?
    !!current_user
  end

  def require_user
    if !logged_in?
      flash[:notice] = 'You must be logged in to perform that action'
      redirect_to login_path
    end
  end
end
