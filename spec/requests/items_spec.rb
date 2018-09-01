require 'rails_helper'

RSpec.describe "Items", type: :request do
  describe "GET list/:list_id/items" do
    let(:session) {FactoryBot.create(:session)}
    let(:list) {FactoryBot.create(:list, user: session.user)}
    before do
      5.times do
        FactoryBot.create(:item, list: list, user: session.user)
      end
    end
    it "shows the items in list of user" do
      headers = sign_in_test_headers session
      get list_items_path(list), headers: headers
      expect(response).to have_http_status(200)
      json = JSON.parse(response.body)
      expect(json.length).to eq 5
    end
    it "gives 401 if user not signed in" do
      get list_items_path(list)
      expect(response).to have_http_status(401)
    end
    it "gives 404 if user not owner of list" do
      session = FactoryBot.create(:session)
      headers = sign_in_test_headers session
      get list_items_path(list), headers: headers
      expect(response).to have_http_status(404)
    end
  end

  describe "GET /lists/:list_id/items/:id" do
    let(:session) {FactoryBot.create(:session)}
    let(:list) {FactoryBot.create(:list, user: session.user)}
    let(:item) {FactoryBot.create(:item, list: list, user: session.user)}
    it "Shows the item for particular list of user" do
      headers = sign_in_test_headers session
      get list_item_path(list, item), headers: headers
      expect(response).to have_http_status(200)
    end
    it "gives 401 if user not signed in" do
      get list_item_path(list, item)
      expect(response).to have_http_status(401)
    end
    it "gives 404 if user not owner of list" do
      session = FactoryBot.create(:session)
      headers = sign_in_test_headers session
      get list_item_path(list, item), headers: headers
      expect(response).to have_http_status(404)
    end
  end

  describe "POST /lists/:list_id/items" do
    let(:session) {FactoryBot.create(:session)}
    let(:list) {FactoryBot.create(:list, user: session.user)}
    it "creates the item in particular list for user" do
      headers = sign_in_test_headers session
      item_params = FactoryBot.attributes_for(:item)
      post list_items_path(list), headers: headers, params: item_params
      expect(response).to have_http_status(201)
    end
    it "gives 401 if user not signed in" do
      item_params = FactoryBot.attributes_for(:item)
      post list_items_path(list), params: item_params
      expect(response).to have_http_status(401)
    end
    it "gives 404 if user not owner of list" do
      session = FactoryBot.create(:session)
      headers = sign_in_test_headers session
      item_params = FactoryBot.attributes_for(:item)
      post list_items_path(list), headers: headers, params: item_params
      expect(response).to have_http_status(404)
    end
  end

  describe "PUT /lists/:list_id/items/:id" do
    let(:session) {FactoryBot.create(:session)}
    let(:list) {FactoryBot.create(:list, user: session.user)}
    let(:item) {FactoryBot.create(:item, list: list, user: session.user)}
    it "edits the item in particular list for user" do
      headers = sign_in_test_headers session
      item_params = FactoryBot.attributes_for(:item, name: "Test Item")
      put list_item_path(list, item), headers: headers, params: item_params
      expect(response).to have_http_status(200)
    end
    it "gives 401 if user not signed in" do
      item_params = FactoryBot.attributes_for(:item)
      put list_item_path(list, item), params: item_params
      expect(response).to have_http_status(401)
    end
    it "gives 404 if user not owner of list" do
      session = FactoryBot.create(:session)
      headers = sign_in_test_headers session
      item_params = FactoryBot.attributes_for(:item)
      put list_item_path(list, item), headers: headers, params: item_params
      expect(response).to have_http_status(404)
    end
  end

  describe "DELETE /lists/:list_id/items/:id" do
    let(:session) {FactoryBot.create(:session)}
    let(:list) {FactoryBot.create(:list, user: session.user)}
    it "deletes the item in particular list for user" do
      item = FactoryBot.create(:item, list: list, user: session.user)
      headers = sign_in_test_headers session
      delete list_item_path(list, item), headers: headers
      expect(response).to have_http_status(204)
    end
    it "gives 401 if user not signed in" do
      item = FactoryBot.create(:item, list: list, user: session.user)
      delete list_item_path(list, item)
      expect(response).to have_http_status(401)
    end
    it "gives 404 if user not owner of list" do
      item = FactoryBot.create(:item, list: list, user: session.user)
      session = FactoryBot.create(:session)
      headers = sign_in_test_headers session
      delete list_item_path(list, item), headers: headers
      expect(response).to have_http_status(404)
    end
  end

  describe "PUT /lists/:list_id/items/:id/change_status" do
    let(:session) {FactoryBot.create(:session)}
    let(:list) {FactoryBot.create(:list, user: session.user)}
    let(:item) {FactoryBot.create(:item, list: list, user: session.user)}
    it "changes the status of the item in particular list for user" do
      headers = sign_in_test_headers session
      put change_status_list_item_path(list, item), headers: headers
      expect(response).to have_http_status(200)
      json = JSON.parse(response.body)
      expect(json['status']).to be_truthy
    end
    it "gives 401 if user not signed in" do
      put change_status_list_item_path(list, item)
      expect(response).to have_http_status(401)
    end
    it "gives 404 if user not owner of list" do
      session = FactoryBot.create(:session)
      headers = sign_in_test_headers session
      put change_status_list_item_path(list, item), headers: headers
      expect(response).to have_http_status(404)
    end
  end
end
