require 'rails_helper'

RSpec.describe Item, type: :model do
  it "has a valid factory" do
    i = FactoryBot.build :item
    expect(i.valid?).to be_truthy
  end

  describe "#change_status!" do
    it "changes the status of item" do
      i = FactoryBot.create :item
      expect(i.status).to be_falsey
      i.change_status!
      expect(i.status).to be_truthy
      i.change_status!
      expect(i.status).to be_falsey
    end
  end
end
