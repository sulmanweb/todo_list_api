require 'rails_helper'

RSpec.describe User, type: :model do
  it "has a valid factory" do
    user = FactoryBot.build(:user)
    expect(user.valid?).to be_truthy
  end

  # password_required? testing
  it "gives error if password not provided while creating" do
    user = FactoryBot.build(:user, password: nil)
    expect(user.valid?).to be_falsey
  end

  describe "convert_auth_to_small_letters" do
    it "conversts the input auth to small letters" do
      user = FactoryBot.create(:user, email: 'Sulmanweb@gmail.com')
      expect(user.email).to eql ('sulmanweb@gmail.com')
    end
  end
end
