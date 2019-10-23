class RegistrationsController < Devise::RegistrationsController

  def new
    super
  end
  
  def create
    if SecretCode.pluck(:secret_code).include?(params[:user][:secret_code].to_s)
      super
      secret_code = SecretCode.find_by(:secret_code => params[:user][:secret_code])
      secret_code.user_id = resource.id
      secret_code.save
    else
      binding.pry
      render  :new
    end
    # @user = User.find_by_email(user_params[:email])
    # if @user && @user.valid_password?(user_params[:password]) && @user.has_two_factor_auth?
    #   unless verify_tfa_by_cookie(@user, request.user_agent)
    #     session[:current_user_id] = @user.id
    #     if @user.send_otp     # Sent Mail with OTP
    #       @message, @msg_type = ["Security token has been sent to your email address (same as your login ID). Please check  your inbox.", 'login-notice']
    #       respond_to do |format|
    #         format.html{ render :two_factor_auth }
    #       end
    #     else
    #       respond_to do |format|
    #         format.html{ redirect_to :back, alert: 'Unable to send OTP!! Try again.' }
    #       end
    #     end
    #   else
    #     after_successful_sign_in(@user)
    #   end
    # else
    #   super
    # end
  end
end
