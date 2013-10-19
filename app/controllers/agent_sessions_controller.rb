# -*- encoding : utf-8 -*-
class AgentSessionsController < ApplicationController
  skip_before_filter :authenticate_user!

  def create
    user = User.find(params[:user_id])
    if user && user.email == 'info@lab2023.com'
      sign_in user, :bypass => true
    else
      flash[:notice] = "Wrong account info !!!"
    end
    redirect_to root_url
  end
end