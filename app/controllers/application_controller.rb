class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  include Pundit
  protect_from_forgery with: :exception
  layout :layout_by_resource
  before_filter :set_search

  # rescue from pundit by going the function
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private

  # alert user for unauthorized usage
  def user_not_authorized
    flash[:alert] = "You are not authorized to perform this action."
    redirect_to(request.referrer || root_path)
  end

  def set_search
    @co=Course.search(params[:q])
    @re=Recipe.search(params[:q])
    @ca=Cast.search(params[:q])
  end


  protected

  def layout_by_resource
    if devise_controller? && resource_name == :user && action_name == "new"
      "empty"
    else
      "application"
    end
  end
end
