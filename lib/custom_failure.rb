  class CustomFailure < Devise::FailureApp
    def redirect_url
       #new_user_session_url(:subdomain => 'secure')
       users_sign_up_url
    end

    # You need to override respond to eliminate recall
    def respond
      if http_auth?
        http_auth
      else
        redirect
      end
    end
  end