class User < ApplicationRecord
  # password encryption
  has_secure_password

  # validations
  validates :email, presence: true, uniqueness: true, format: {with: /\A([\w+\-]\.?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/, message: I18n.t('errors.users.format_email')}
  validates :password, format: {with: /\A(?=.*[a-zA-Z])(?=.*[0-9]).{8,72}\z/, message: I18n.t('errors.users.format_password')}, if: :password_required? # defined below

  # callbacks
  before_save :convert_auth_to_small_letters

  # Relationships
  has_many :lists, dependent: :destroy
  has_many :items, dependent: :destroy

  private

  # whether password is required field or not
  def password_required?
    password_digest.nil? || !password.blank?
  end

  # Convert auth to small letters
  def convert_auth_to_small_letters
    email.downcase!
  end
end
