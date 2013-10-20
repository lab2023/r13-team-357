class User::ParameterSanitizer < Devise::ParameterSanitizer
  private
  def sign_up
    default_params.permit(:email, :password, :password_confirmation, :time_zone, profile_attributes: [:name]) # TODO add other params here
  end
end
