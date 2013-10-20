class RegistrationsController < Devise::RegistrationsController
  def edit
    add_breadcrumb current_user.name, edit_registration_path(current_user)
  end
end