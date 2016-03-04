require 'pry'

class RegistrationsController < Devise::RegistrationsController
  
  rescue_from CanCan::AccessDenied do |exception|
    head :bad_request
  end

  def new

    build_resource({})
    set_minimum_password_length
    yield resource if block_given?

    respond_with self.resource
  end

  def create
    build_resource(sign_up_params)
    if User.where(email: resource.email).exists? && User.where(email: resource.email).first.uid != nil
      user = User.where(email: resource.email).first
      user.send_reset_password_instructions
      redirect_to new_user_registration_path
      return
    else
      resource.save
    end
    yield resource if block_given?
    if resource.persisted?
      if resource.active_for_authentication?
        set_flash_message! :notice, :signed_up
        sign_up(resource_name, resource)
        respond_with resource, location: after_sign_up_path_for(resource)
      else
        set_flash_message! :notice, :"signed_up_but_#{resource.inactive_message}"
        expire_data_after_sign_in!
        respond_with resource, location: after_inactive_sign_up_path_for(resource)
      end
    else
      clean_up_passwords resource
      set_minimum_password_length
      resource.errors.each do |key, value|
        flash["#{key}"] = "#{key.capitalize}: #{value}"
      end
      
      binding.pry
      redirect_to new_user_registration_path
    end
  end
  
  def update
    user = params.key?(:id) ? User.find(params[:id]) : resource
    authorize! :update, user
    valid_param = false
    self.resource = resource_class.to_adapter.get!(send(:"current_#{resource_name}").to_key)
    prev_unconfirmed_email = resource.unconfirmed_email if resource.respond_to?(:unconfirmed_email)
    if !params[:name].nil?
      # Move to separate model
      case params[:name]
      when "bio"
        account_update_params = {:bio => params[:value]}
        valid_param = true
      when "age"
        account_update_params = {:age => params[:value]}
        valid_param = true
      when "style_likes"
        account_update_params = {:style_likes => params[:value]}
        valid_param = true
      when "style_dislikes"
        account_update_params = {:style_dislikes => params[:value]}
        valid_param = true
      when "style_icon"
        account_update_params = {:style_icon => params[:value]}
        valid_param = true
      end
    end
    sanitized_params = account_update_params()
    resource_updated = update_resource(resource, sanitized_params)
    yield resource if block_given?
    if resource_updated
      if is_flashing_format?
        flash_key = update_needs_confirmation?(resource, prev_unconfirmed_email) ?
          :update_needs_confirmation : :updated
        set_flash_message :notice, flash_key
      end
      sign_in resource_name, resource, bypass: true
      if params[:name].nil? || valid_param != true
        respond_with resource, location: after_update_path_for(resource)
      else
        return head :ok
      end
    else
      clean_up_passwords resource
      respond_with resource
    end
  end    
    
  protected
  
    def after_update_path_for(resource)
      user_show_path(resource)
    end
    
    def update_resource(resource, params)
      if ((params.key?(:email)) && (params[:email] != resource.email)) || (params.key?(:password) && !params[:password].blank?) || (params.key?(:password_confirmation) && !params[:password_confirmation].blank?)
        resource.update_with_password(params)
      else
        params.delete(:current_password) if params.key?(:current_password)
        resource.update_without_password(params)
      end
    end
      
end
