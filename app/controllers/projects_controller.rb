# encoding: UTF-8
class ProjectsController < ApplicationController
  skip_before_action :redirect_to_new_project
  before_action :set_project, only: [:show]
  add_breadcrumb I18n.t('activerecord.models.project'), :projects_path
  def index
    @search = current_user.projects.search(params[:q])
    @projects = @search.result(:distinct => true).paginate(:page => params[:page])
    respond_with(@projects)
  end

  def show
    add_breadcrumb @project.name, project_path(@project)
    @current_project = @project
    session[:project_id] = @current_project.id
    #@lists = List.where(:project_id => @project.id).order('sort asc')
    @lists = @current_project.lists.order('sort asc')

    respond_with(@lists)
  end

  def new
    add_breadcrumb t('tooltips.new'), new_project_path
    @project = current_user.projects.new
    # Build default lists
    Settings.default_lists.each do |list|
      @project.lists.build(name: list)
    end
    respond_with(@project)
  end

  def edit
    @project = current_user.own_projects.find(params[:id])
    add_breadcrumb @project.id, project_path(@project)
    add_breadcrumb t('tooltips.edit'), edit_project_path
  end

  def create
    @project = current_user.own_projects.new(project_params)
    @project.owner = current_user
    if @project.save
      @project.users << current_user
      @current_project = @project
    end
    session[:project_id] = @current_project.id
    respond_with(@project)
  end

  def update
    @project = current_user.own_projects.find(params[:id])
    @project.update(project_params)
    respond_with(@project)
  end

  def destroy
    @current_project = current_user.own_project.last if @current_project == @project
    @project = current_user.own_projects.find(params[:id])
    @project.users.clear
    @project.destroy
    respond_with(@project)
  end

  def auto_users
    search = User.search(:profile_name_or_email_start => params[:term])
    users = search.result(:distinct => true).limit(10) - @current_project.users
    render :json => users.map {|p| Hash[id: p.id, label: "#{p.name} - #{p.email}", name: p.id]}
  end

  private

  def set_project
    @project = current_user.projects.find(params[:id])
  end

  def project_params
    params.require(:project).permit(:name, :description, lists_attributes: [:id, :name, :_destroy])
  end
end
