require 'application_responder'

class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :set_user_time_zone
  before_action :set_quest_user
  before_action :get_version
  before_action :set_current_project, :if => :user_signed_in?
  before_action :redirect_to_new_project, :if => :user_signed_in?


  self.responder = ApplicationResponder
  respond_to :html, :json
  WillPaginate.per_page = 10

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception


  def get_percentage(card)
    checklist_percentage = 0
    if card.try(:checklist_total_count).to_i > 0
      checklist_percentage = 100 * card.try(:checklist_done_count).to_i / card.try(:checklist_total_count).to_i
    end
    checklist_percentage
  end

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
    unless current_user
      @guest_user = User.where(email: 'info@lab2023.com').last
    end
  end

  def get_version
    IO.foreach('public/version.txt') do |line|
      @version = line
      @version = "v #{@version}"
    end
  end

  def set_current_project
    @current_project = set_current_project_from_session || current_user.projects.first
    session[:project_id] = @current_project.id if @current_project.present?
  end

  def set_current_project_from_session
    if session[:project_id]
      begin
        current_user.projects.find(session[:project_id])
      rescue
        session[:project_id] = nil
      end
    end
  end


  def after_sign_in_path_for(resource_or_scope)
    if current_user
      current_user.projects.size > 0 ? project_path(@current_project) : new_project_path

    else
      hq_dashboard_index_path
    end
  end

  def redirect_to_new_project
    redirect_to new_project_path if current_user.projects.size < 1
  end

end