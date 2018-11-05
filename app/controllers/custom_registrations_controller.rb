class CustomRegistrationsController < Devise::RegistrationsController

  protected

    def after_update_path_for(resource)
      if resource.sign_in_count == 1
        destroy_user_session_path
      else
        root_path
      end
    end
end
