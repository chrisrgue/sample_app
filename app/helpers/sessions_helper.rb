module SessionsHelper

  def log_in(user)
    session[:user_id] = user.id
  end

  def current_user
    if session[:user_id]
      @current_user ||= User.find_by id: session[:user_id]
      # Using find_by which returns nil if the obtained user_id is invalid
      # ('find(session[:user_id])' wuld throw an exception in this case
      # which we dont want because this helper might often be called in a context
      # where a user hasn't yet logged in)
    end
  end

  def logged_in?
    !current_user.nil?
  end

  def log_out
    session.delete(:user_id)
    @current_user = nil
  end
end
