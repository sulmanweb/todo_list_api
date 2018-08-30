class Item < ApplicationRecord
  # Relationships
  belongs_to :user
  belongs_to :list

  # Validations
  validates :name, presence: true
end
