require 'rails_helper'

RSpec.describe "Lists", type: :request do
  describe "GET /lists" do
    let(:session) {FactoryBot.create(:session)}
    before do
      5.times do
        FactoryBot.create(:list, user: session.user)
      end
    end
    it "show the lists of user" do
      headers = sign_in_test_headers session
      get lists_path, headers: headers
      expect(response).to have_http_status(200)
      json = JSON.parse(response.body)
      expect(json.length).to eq 5
    end
    it "gives error if user not signed in" do
      get lists_path
      expect(response).to have_http_status(401)
    end
  end

  describe "GET /lists/:id" do
    let(:session) {FactoryBot.create(:session)}
    let(:list) {FactoryBot.create(:list, user: session.user)}
    it "show the list of user" do
      headers = sign_in_test_headers session
      get list_path(list), headers: headers
      expect(response).to have_http_status(200)
      json = JSON.parse(response.body)
      expect(json.length).to eq 4
    end
    it "gives error if user not signed in" do
      get list_path(list)
      expect(response).to have_http_status(401)
    end
    it "gives 404 if user is not owner of list" do
      session = FactoryBot.create(:session)
      headers = sign_in_test_headers session
      get list_path(list), headers: headers
      expect(response).to have_http_status(404)
    end
  end

  describe "POST /lists" do
    let(:session) {FactoryBot.create(:session)}
    it "create the list for current user" do
      headers = sign_in_test_headers session
      list_params = FactoryBot.attributes_for(:list)
      post lists_path, headers: headers, params: list_params
      expect(response).to have_http_status(201)
    end
    it "gives error if user not signed in" do
      list_params = FactoryBot.attributes_for(:list)
      post lists_path, params: list_params
      expect(response).to have_http_status(401)
    end
    it "gives error if name not present" do
      headers = sign_in_test_headers session
      list_params = FactoryBot.attributes_for(:list, name: nil)
      post lists_path, headers: headers, params: list_params
      expect(response).to have_http_status(422)
    end
  end

  describe "PUT /lists/:id" do
    let(:session) {FactoryBot.create(:session)}
    let(:list) {FactoryBot.create(:list, user: session.user)}
    it "edits the list" do
      headers = sign_in_test_headers session
      list_params = FactoryBot.attributes_for(:list, name: "Test List")
      put list_path(list), headers: headers, params: list_params
      expect(response).to have_http_status(200)
    end
    it "give 404 if user is not owner of list to be edited" do
      session = FactoryBot.create(:session)
      headers = sign_in_test_headers session
      list_params = FactoryBot.attributes_for(:list, name: "Test List")
      put list_path(list), headers: headers, params: list_params
      expect(response).to have_http_status(404)
    end
    it "gives error if name not present" do
      headers = sign_in_test_headers session
      list_params = FactoryBot.attributes_for(:list, name: nil)
      put list_path(list), headers: headers, params: list_params
      expect(response).to have_http_status(422)
    end
    it "gives error if user not signed in" do
      list_params = FactoryBot.attributes_for(:list, name: "Test List")
      put list_path(list), params: list_params
      expect(response).to have_http_status(401)
    end
  end

  describe "DELETE /list/:id" do
    let(:session) {FactoryBot.create(:session)}
    it "deletes the list" do
      headers = sign_in_test_headers session
      list = FactoryBot.create(:list, user: session.user)
      delete list_path(list), headers: headers
      expect(response).to have_http_status(204)
    end
    it "give 404 if user is not owner of list to be deleted" do
      list = FactoryBot.create(:list, user: session.user)
      session = FactoryBot.create(:session)
      headers = sign_in_test_headers session
      delete list_path(list), headers: headers
      expect(response).to have_http_status(404)
    end
    it "gives error if user not signed in" do
      list = FactoryBot.create(:list, user: session.user)
      delete list_path(list)
      expect(response).to have_http_status(401)
    end
  end
end
