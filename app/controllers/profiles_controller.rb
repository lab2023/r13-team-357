class ProfilesController < ApplicationController
  def show
    @profile = Profile.find(params[:id])
    add_breadcrumb @profile.name, profile_path(@profile)
  end

  def edit
    @profile = current_user.profile
    add_breadcrumb @profile.name, profile_path(@profile)
    add_breadcrumb 'Edit', edit_profile_path(@profile)
  end

  def update
    current_user.profile.update(profile_params)
    respond_with current_user.profile
  end

  def profile_params
    params.require(:profile).permit(:name, :bio, :blog, :github, :stackoverflow, :linkedin, :twitter, :facebook)
  end
end
