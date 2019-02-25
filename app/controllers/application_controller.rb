class ApplicationController < ActionController::Base
  # protect_from_forgery with: :exception

 #  skip_before_action :verify_authenticity_token
	# before_action :verify_token
  # before_action :check_terms

  def verify_token
  	@token = ApiToken.where(token: params[:token], expire: nil).last
      unless @token.present?
          render json:{
          	message: "Invalid Token!",
          	success: false
          }
      else
         @user = @token.user
         # @trip = @token.user.trips.last
      end    
  end

  def two_factor_auth_verified?(code)
    return false unless current_user.two_factor_enabled?
    current_user.validate_and_consume_otp!(code)
  end



  # def check_terms
  #   if @user.terms_accepted
  #     return true
  #   else
  #     render json:{
  #       success: false,
  #       message: 'Please accept privacy and eligibility'
  #     }
  #   end
  # end
end
