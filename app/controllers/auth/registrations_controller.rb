require 'user.rb'
class Auth::RegistrationsController < ApplicationController
  # TODO add forget password services

  before_action :authenticate_user, only: [:destroy]

  def create
    @user = User.new register_params

    if @user.save
      # Signing in user successfully registered
      @command = AuthenticateUser.call(register_params[:email], register_params[:password])
      if @command.success?
        return render_success_register_user
      else
        return render_error_login
      end
    else
      return render_error_save_user
    end
  end

  def destroy
    current_user.destroy!
    render status: :no_content, json: {}
  end

  protected

  def render_success_register_user
    render status: :created, template: 'auth/login.json.jbuilder'
  end

  def render_error_save_user
    render status: :unprocessable_entity, json: {errors: @user.errors.full_messages}
  end

  def render_error_login
    render status: :unauthorized, json: {errors: @command.errors[:user_authentication]}
  end

  private

  def register_params
    params[:email].downcase! if params[:email].present?
    params.permit :email, :password, :name
  end
end