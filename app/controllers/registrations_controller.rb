class RegistrationsController < Devise::RegistrationsController
  skip_before_action :redirect_to_new_project
  def edit
    add_breadcrumb current_user.name, edit_registration_path(current_user)
  end
end