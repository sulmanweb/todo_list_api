class ApplicationController < ActionController::API
  # jwt exception settings
  include ExceptionHandler

  # auth functions
  attr_reader :current_user

  # calls the auth/authorize_request.rb to get current_user
  # Also removed get_current_user authentication file as we will not having common data in this project
  def authenticate_user
    @current_user = AuthorizeRequest.call(request.headers).result
    return render status: :unauthorized, json: {errors: ['Unauthorized']} unless @current_user
  end
end
