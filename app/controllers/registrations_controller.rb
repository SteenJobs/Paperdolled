class RegistrationsController < Devise::RegistrationsController
  
  
  protected
  
    def after_update_path_for(resource)
      user_path(resource)
    end
    
    def update_resource(resource, params)
      if (params[:email] != resource.email) || !(params[:password] || params[:password_confirmation]).blank?
        resource.update_with_password(params)
      else
        resource.update_without_password(params)
      end
    end
end
