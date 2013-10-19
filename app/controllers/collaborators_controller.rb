class CollaboratorsController < ApplicationController

  def index
    @project = current_user.projects.find(params[:project_id])
    @project_user = ProjectsUser.new
  end

  def create
    @project_user = ProjectsUser.create(collaboration_params)
    @project = @project_user.project
    respond_with(@project, location: users_project_path(@project))
  end

  private

  def collaboration_params
    params.require(:projects_user).permit(:project_id, :user_id)
  end
end
