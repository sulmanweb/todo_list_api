require 'rails_helper'

RSpec.describe Item, type: :model do
  it "has a valid factory" do
    i = FactoryBot.build :item
    expect(i.valid?).to be_truthy
  end
end
