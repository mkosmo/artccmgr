# frozen_string_literal: true

class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  # Callback method to handle SSO failures
  #
  def failure(reason = "OAuth failure")
    set_flash_message(:notice,
                      :failure,
                      kind:   "VATSIM",
                      reason: reason)
    redirect_to root_path
  end

  # Callback method to handle the SSO callback from Omniauth/VATSIM SSO
  #
  def vatsim
    sso_data = request.env["omniauth.auth"]

    begin
      sso_info = sso_data.info
      cid      = sso_data.info.id.to_i
    rescue NoMethodError
      failure("OAuth did not return user information")
      return
    end

    @user = User.find_or_initialize_by(cid: cid)

    # Check for changes since last login or populate data
    reconcile_vatsim_data @user, sso_info
    sign_in_and_redirect @user, event: :authentication
  end

  private

    # Reconcile VATSIM data with local user data
    #
    def reconcile_vatsim_data(user, vatsim)
      user.first_name = vatsim.name_first
      user.last_name  = vatsim.name_last
      user.email      = vatsim.email
      user.rating     = Vatsim::Rating.find_by(vatsim_id: vatsim.rating.id.to_i)
      user.reg_date   = vatsim.reg_date

      user.save if user.changed?
    end
end
