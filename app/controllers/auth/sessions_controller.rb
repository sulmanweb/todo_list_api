class Auth::SessionsController < ApplicationController

  before_action :authenticate_user, only: %i[destroy]

  def create
    params[:email].downcase! if params[:email].present?
    authenticate params[:email], params[:password]
  end

  def destroy
    headers = request.headers['Authorization'].split(' ').last
    session = Session.find_by(uid: JsonWebToken.decode(headers)[:uid])
    session.update(status: false)
    render status: :no_content, json: {}
  end

  private

  # verifies the auth params and then creates session
  def authenticate auth, password
    @command = AuthenticateUser.call(auth, password)

    if @command.success?
      @user = User.find_by_email(auth)
      return render_success_login
    else
      return render_error_login
    end
  end

  protected

  def render_success_login
    render status: :created, template: 'auth/login.json.jbuilder'
  end

  def render_error_login
    render status: :unauthorized, json: {errors: @command.errors[:user_authentication]}
  end
end