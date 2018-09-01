class Session < ApplicationRecord
  # Relationships
  belongs_to :user

  # Validations
  validates :uid, presence: true, uniqueness: true, length: {is: UID_LENGTH}

  # Callbacks
  before_validation :generate_uid, on: :create
  after_create :used!

  # Methods

  # find the active session based on the uid provided
  def self.find_session token
    find_by(status: true, uid: token)
  end

  # Logout the active session
  def logout!
    update(status: false)
  end

  # Session last used at update to current time
  def used!
    update(last_used_at: Time.zone.now)
  end

  private

  # Generate random unique utoken for the model
  def generate_uid
    self.uid = loop do
      random_token = SecureRandom.base58(UID_LENGTH)
      break random_token unless Session.exists?(uid: random_token)
    end
  end
end
