require 'application_responder'

class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :set_user_time_zone
  before_action :set_quest_user
  before_action :get_version
  add_breadcrumb "Dashboard", :dashboard_index_path

  self.responder = ApplicationResponder
  respond_to :html, :json
  WillPaginate.per_page = 10

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  protected
  def set_user_time_zone
    Time.zone = current_user.time_zone if user_signed_in? && current_user.time_zone.present?
  end

  def devise_parameter_sanitizer
    if resource_class == User
      User::ParameterSanitizer.new(User, :user, params)
    else
      super # Use the default one
    end
  end

  def set_quest_user
    @guest_user = User.where(email: 'info@lab2023.com').last
  end

  def get_version
    IO.foreach('public/version.txt') do |line|
      @version = line
      @version = "v #{@version}"
    end
  end


  def after_sign_in_path_for(resource_or_scope)
    if current_user
      dashboard_index_path
    else
      hq_dashboard_index_path
    end
  end

end