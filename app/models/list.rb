class List < ApplicationRecord
  # TODO add sequence number to lists for arranging manually

  # Relationships
  belongs_to :user

  # validations
  validates :name, presence: true
end
