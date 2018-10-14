class SessionsController < ApplicationController
  skip_before_action :require_user, only: %i[new create]

  def new

  end

  def create
    student = Student.find_by(email: params[:sessions][:email].downcase)
    if student &.authenticate(params[:sessions][:password])
      session[:student_id] = student.id
      flash[:notice] = 'You have succesfully logged in'
      redirect_to student
    else
      flash.now[:notice] = 'Something is not correct'
      render 'new'
    end
  end

  def destroy
    session[:student_id] = nil
    flash[:notice] = 'You have succesfully logged out'
    redirect_to root_path
  end
end
