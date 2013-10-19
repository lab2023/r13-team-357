# encoding: UTF-8
class CurrentProjectsController < ApplicationController

  def create
    @project = current_user.projects.find(params[:project_id])
    @current_project = @project
    session[:project_id] = @project.id
    respond_with(@project)
  end
end
