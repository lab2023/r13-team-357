class CollaboratorsController < ApplicationController

  def index
    @project = current_user.projects.find(params[:project_id])
  end

  def create
    @project = current_user.projects.find(params[:project_id])
    @user = User.find(params[:user_id])
    @project.users << @user
    respond_with(@project, location: users_project_path(@project))
  end
end
