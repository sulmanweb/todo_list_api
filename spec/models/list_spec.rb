require 'rails_helper'

RSpec.describe List, type: :model do
  it "has a valid factory" do
    l = FactoryBot.build :list
    expect(l.valid?).to be_truthy
  end

  it "gives error if user doesnot exist" do
    l = FactoryBot.build(:list, user_id: nil)
    expect(l.valid?).to be_falsey
  end
end
