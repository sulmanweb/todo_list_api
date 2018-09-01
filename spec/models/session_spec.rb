require 'rails_helper'

RSpec.describe Session, type: :model do
  it "has a valid factory" do
    session = FactoryBot.build(:session)
    expect(session.valid?).to be_truthy
  end

  it "generates last used at after create" do
    session = FactoryBot.create(:session)
    expect(session.last_used_at).to_not eql nil
  end

  it "must have a uid" do
    session = FactoryBot.build(:session)
    session.valid?
    expect(session.uid).to_not eql nil
  end

  describe "find_session" do
    it "find active session" do
      session = FactoryBot.create(:session)
      expect(Session.find_session(session.uid)).to eql session
      expect(Session.find_session('sahdbcajscb')).to eql nil
    end
  end

  describe "logout!" do
    it "logouts the session" do
      session = FactoryBot.create(:session)
      session.logout!
      expect(Session.find_session session.uid).to eql nil
    end
  end

  describe "used!" do
    it "updates the used last time" do
      session = FactoryBot.create(:session)
      session.update(last_used_at: 2.seconds.ago)
      time = session.last_used_at
      session.used!
      expect(session.last_used_at).to_not eql time
    end
  end
end
