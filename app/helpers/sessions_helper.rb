module SessionsHelper
  def sign_in(user)
    cookies.permanent[:remember_token] = user.remember_token
    self.current_user = user
  end

  def sign_out 
    self.current_user = nil 
    cookies.delete(:remember_token) 
  end 

  def current_user=(user)
    @current_user = user
  end

  def current_user
    user = Student.find_by_remember_token(cookies[:remember_token])
    if !user
      user = Teacher.find_by_remember_token(cookies[:remember_token])
      if !user
        user = Admin.find_by_remember_token(cookies[:remember_token])
      end
    end
    @current_user ||= user
  end

  def signed_in?
    !current_user.nil?
  end
end
