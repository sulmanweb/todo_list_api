class Item < ApplicationRecord
  # Relationships
  belongs_to :user
  belongs_to :list

  # Validations
  validates :name, presence: true

  ## methods
  # change the status of item
  def change_status!
    if status
      update(status: false)
    else
      update(status: true)
    end
  end
end
