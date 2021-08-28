class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  skip_before_action :verify_authenticity_token, only: :todoist

  def todoist
    @user = User.from_omniauth(request.env["omniauth.auth"])

    if @user.persisted?
      @user.remember_me = true
      sign_in_and_redirect @user, event: :authentication # this will throw if @user is not activated
      set_flash_message(:notice, :success, kind: "Todoist") if is_navigational_format?
    else
      session["devise.todoist_data"] = request.env["omniauth.auth"].except(:extra) # Removing extra as it can overflow some session stores
      redirect_to new_user_registration_path
    end
  end

  def failure
    redirect_to root_path
  end
end
