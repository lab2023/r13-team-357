class SessionsController < Devise::SessionsController
  skip_before_action :redirect_to_new_project
end