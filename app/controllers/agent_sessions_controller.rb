# -*- encoding : utf-8 -*-
class AgentSessionsController < ApplicationController
  skip_before_action :verify_authenticity_token
  skip_before_action :authenticate_user!

  def create
    user = User.find(params[:user_id])
    if user && user.email == 'info@lab2023.com'
      sign_in user, :bypass => true
      if user.projects.present?
        redirect_to project_path user.projects.last
      else
        redirect_to new_project_path
      end

    else
      flash[:notice] = "Wrong account info !!!"
      redirect_to new_user_session_path
    end
  end
end