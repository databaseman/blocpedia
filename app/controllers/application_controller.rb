class ApplicationController < ActionController::Base
    # Prevent CSRF attacks by raising an exception.
    # For APIs, you may want to use :null_session instead.
    include Pundit
    require 'will_paginate/array' #need this for will_pagination to work with Pundit
    protect_from_forgery with: :exception

    before_action :configure_permitted_parameters, if: :devise_controller?

    rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

    protected
        def configure_permitted_parameters
            devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:name, :email, :password, :role) }
            devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:name, :email, :password, :current_password, :role) }
        end

    private
      def user_not_authorized
        flash[:danger] = "You are not authorized to perform this action."
        redirect_to(request.referrer || root_path)
      end       
end
