class RegistrationsController < Devise::RegistrationsController
  
  
  def update
    self.resource = resource_class.to_adapter.get!(send(:"current_#{resource_name}").to_key)
    prev_unconfirmed_email = resource.unconfirmed_email if resource.respond_to?(:unconfirmed_email)
    if !params[:bio].nil?
      account_update_params = {:bio => params[:bio]}
    end
    resource_updated = update_resource(resource, account_update_params)
    yield resource if block_given?
    if resource_updated
      if is_flashing_format?
        flash_key = update_needs_confirmation?(resource, prev_unconfirmed_email) ?
          :update_needs_confirmation : :updated
        set_flash_message :notice, flash_key
      end
      sign_in resource_name, resource, bypass: true
     respond_with resource, location: after_update_path_for(resource)
    else
      clean_up_passwords resource
      respond_with resource
    end
  end    
    
  protected
  
    def after_update_path_for(resource)
      user_path(resource)
    end
    
    def update_resource(resource, params)
      if (params[:email] != resource.email) && (params[:email] != nil) || !params[:password].blank? || !params[:password_confirmation].blank?
        resource.update_with_password(params)
      else
        params.delete(:current_password)
        resource.update_without_password(params)
      end
    end
      
end
