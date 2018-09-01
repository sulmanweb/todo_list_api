class AuthorizeRequest
  prepend SimpleCommand

  def initialize(headers = {})
    @headers = headers
  end

  def call
    user
  end

  private

  attr_reader :headers

  def user
    @user = nil
    if decoded_auth_token
      session = Session.find_session decoded_auth_token[:uid]
      if !session.nil? && session.user_id == decoded_auth_token[:user_id]
        if session.last_used_at + SESSION_TOKEN_LIFETIME < Time.zone.now
          session.logout!
        else
          session.used!
          @user = session.user
        end
      end
    end
    @user || errors.add(:token, I18n.t('errors.users.invalid_token')) && nil
  end

  def decoded_auth_token
    @decoded_auth_token ||= JsonWebToken.decode(http_auth_header)
  end

  def http_auth_header
    if headers['Authorization'].present?
      return headers['Authorization'].split(' ').last
    else
      errors.add(:token, I18n.t('errors.users.token_missing'))
    end
    nil
  end
end