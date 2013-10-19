class CollaboratorsController < ApplicationController

  def index
    @collaborators = @current_project.users
  end

  def create
    value = params[:project][:user_ids]
    email = value.split('-').last
    Rails.logger.info email.strip
    user = User.where(email: email.strip).last
    unless @current_project.users.include?(user)
      @current_project.users << user
    end

    respond_to do |format|
      format.js
    end
  end

  def destroy
    email = params[:email]
    user = @current_project.users.where(email: email).last
    unless user == @current_project.owner
      @current_project.users.delete(user)
    end
    respond_to do |format|
      format.js
    end
  end

  private

  def collaboration_params
    params.require(:projects_user).permit(:project_id, :user_id)
  end
end
