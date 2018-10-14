class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  # makes these methdos available even to views
  helper_method :current_user, :logged_in?

  def current_user
    # memoisation - doesn't call to db if no @current_user object
    @current_user ||= Student.find(session[:student_id]) if session[:student_id]
  end

  def logged_in?
    !!current_user
  end
end
