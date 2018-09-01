class ApplicationController < ActionController::API
  # jwt exception settings
  include ExceptionHandler

  # for pundit authorizations
  include Pundit
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  # auth functions
  attr_reader :current_user

  # calls the auth/authorize_request.rb to get current_user
  # Also removed get_current_user authentication file as we will not having common data in this project
  def authenticate_user
    @current_user = AuthorizeRequest.call(request.headers).result
    return render status: :unauthorized, json: {errors: ['Unauthorized']} unless @current_user
  end

  private

  def user_not_authorized exception
    policy_name = exception.policy.class.to_s.underscore
    render json: {errors: [I18n.t("#{policy_name}.#{exception.query}", scope: "pundit", default: :default)]}, status: :forbidden
  end
end
