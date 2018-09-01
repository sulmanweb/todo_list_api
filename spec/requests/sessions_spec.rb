require 'rails_helper'

RSpec.describe "Sessions", type: :request do
  describe "POST /auth/sign_in" do
    it "creates a new token for user in system" do
      user = FactoryBot.create(:user)
      post auth_sign_in_path, params: {email: user.email, password: user.password}
      expect(response).to have_http_status(201)
      json = JSON.parse(response.body)
      expect(json.length).to eq 2
      current_user = User.find_by_id(JsonWebToken.decode(json['token'])[:user_id])
      expect(current_user.nil?).to be_falsey
    end

    it "gives 401 if invalid credentials provided" do
      user = FactoryBot.create(:user)
      post auth_sign_in_path, params: {email: user.email, password: 'abcd'}
      expect(response).to have_http_status(401)
      json = JSON.parse(response.body)
      expect(json.length).to eq 1
      post auth_sign_in_path, params: {email: user.email + "ab", password: user.password}
      expect(response).to have_http_status(401)
      json = JSON.parse(response.body)
      expect(json.length).to eq 1
    end
  end

  describe "DELETE auth/sign_out" do
    let(:session) {FactoryBot.create(:session)}
    it "destroys user session" do
      headers = sign_in_test_headers session
      delete auth_sign_out_path, headers: headers
      expect(response).to have_http_status(204)
    end
    it "gives error if user not signed in" do
      delete auth_sign_out_path
      expect(response).to have_http_status(401)
    end
    it "gives error if wrong tokens" do
      session = FactoryBot.create(:session)
      session.uid = 'aaaaaaaaaaaaaaaaaaaaa'
      headers = sign_in_test_headers session
      delete auth_sign_out_path, headers: headers
      expect(response).to have_http_status(401)
    end
  end
end
