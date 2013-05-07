class SessionsController < ApplicationController
  def new
  end

  def create
    user = Student.find_by_email(params[:session][:email].downcase)
    if !user
      user = Teacher.find_by_email(params[:session][:email].downcase)
      if !user
        user = Admin.find_by_email(params[:session][:email].downcase)
      end
    end
    if user && user.authenticate(params[:session][:password])
      sign_in user
      redirect_to user
    else
      flash.now[:error] = 'Invalid email/password combination'
      render 'new'
    end
  end

  def destroy
    sign_out
    redirect_to root_url
  end
end
