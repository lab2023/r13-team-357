# -*- encoding : utf-8 -*-
class AgentSessionsController < ApplicationController
  skip_before_filter :authenticate_user!

  def create
    user = User.find(params[:user_id])
    if user && user.email == 'info@lab2023.com'
      sign_in user, :bypass => true
      redirect_to dashboard_index_path
    else
      flash[:notice] = "Wrong account info !!!"
      redirect_to new_user_session_path
    end
  end
end