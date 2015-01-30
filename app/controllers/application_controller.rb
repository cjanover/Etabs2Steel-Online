class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  protected
    # Returns the currently logged in user or nil if there isn't one
    helper_method :current_user
    def current_user
      return unless session[:user_id]
      @current_user ||= User.find_by_id(session[:user_id])
    end
    
    helper_method :current_analysis
    def current_analysis
      if (params[:analysis_id] == nil)
        return
      else
        @current_analysis = current_model.analyses.find_by_id(params[:analysis_id])
      end
    end
    
    helper_method :current_model
    def current_model
      if params[:model_id] == nil
        return
      else
        @current_model = current_user.models.find_by_id(params[:model_id])
      end
    end
    
    helper_method :current_default
    def current_default
      if params[:analysis_id] == nil
        @current_default = current_user.profile.defaults.find_by name: current_user.profile.active_name
      else
        @current_default = current_user.models.find_by_id(params[:model_id]).analyses.find_by_id(params[:analysis_id]).default
      end
      
      #return if current_user.profile.active_name == nil
      #@current_default = current_user.profile.defaults.find_by name: current_user.profile.active_name
    end
    
    helper_method :format_value
    def format_value(value)
      value ||= 'N/A'
    end
    # Filter method to enforce a login requirement
    # Apply as a before_action on any controller you want to protect
    def authenticate
      logged_in? || access_denied
    end
    # Predicate method to test for a logged in user
    def logged_in?
      current_user.is_a? User
    end
    # Make logged_in? available in templates as a helper
    helper_method :logged_in?
    def access_denied
      redirect_to login_path, notice: "Please log in to continue" and return false
    end
  
end
