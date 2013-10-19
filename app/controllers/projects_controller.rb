# encoding: UTF-8
class ProjectsController < ApplicationController
  before_action :set_project, only: [:show, :edit, :update, :destroy]
  add_breadcrumb I18n.t('activerecord.models.projects'), :projects_path
  def index
    @search = current_user.projects.search(params[:q])
     @projects = @search.result(:distinct => true).paginate(:page => params[:page])
     respond_with(@projects)
  end

  def show
    add_breadcrumb @project.name, project_path(@project)
    respond_with(@project)
  end

  def new
    add_breadcrumb t('tooltips.new'), new_project_path
    @project = current_user.projects.new
    respond_with(@project)
  end

  def edit
    add_breadcrumb @project.id, project_path(@project)
    add_breadcrumb t('tooltips.edit'), edit_project_path
  end

  def create
    @project = current_user.projects.new(project_params)
    @project.owner = current_user
    @project.save
    @project.users << current_user
    respond_with(@project)
  end

  def update
    @project.update(project_params)
    respond_with(@project)
  end

  def destroy
    @project.destroy
    respond_with(@project)
  end

  def auto_users
    search = User.search(:name_or_email_start => params[:term])
    users = search.result(:distinct => true).limit(10)
    render :json => users.map {|p| Hash[id: p.id, label: p.name, name: p.id]}
  end

  private

  def set_project
    @project = current_user.projects.find(params[:id])
  end

  def project_params
    params.require(:project).permit(:name)
  end
end
