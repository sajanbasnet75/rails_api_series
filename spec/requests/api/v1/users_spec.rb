require 'rails_helper'

RSpec.describe 'Api::V1::Users', type: :request do
  describe 'GET api/v1/users' do
    it 'returns list of available users' do
      create(:user)
      total_users = User.all.count
      get api_v1_users_path
      expect(response).to have_http_status(200)
      resp = JSON.parse(response.body)
      expect(resp['data'].count).to eq(total_users)
    end
  end

  describe 'GET api/v1/users/:id' do
    it 'returns a user' do
      user = create(:user)
      expected_response = { 'email' => user.email }
      get api_v1_user_path(id: user.id)
      expect(response).to have_http_status(200)
      resp = JSON.parse(response.body)
      expect(resp['data']['attributes']).to include(expected_response)
    end
  end

  describe 'POST /api/v1/users/' do
    it 'creates a new user' do
      total_users = User.all.count
      request_body = {
        user: {
          fullname: 'New User',
          email: 'new@gmail.com',
          encrypted_password: 'asdasd12ad'
        }
      }
      post api_v1_users_path, params: request_body
      expect(response).to have_http_status(201)
      expect(User.all.count).to eq(total_users + 1)
    end

    it 'does not create a new user if email already exists' do
      user = create(:user)
      request_body = {
        user: {
          fullname: 'New User',
          email: user.email,
          encrypted_password: 'asdasd12ad'
        }
      }
      post api_v1_users_path, params: request_body
      expect(response).to have_http_status(422)
    end
  end

  describe 'PUT api/v1/users/:id' do
    it 'updates the user' do
      user = create(:user)
      request_body = {
        user: {
          fullname: 'Updated User'
        }
      }
      put api_v1_user_path(id: user.id), params: request_body
      expect(response).to have_http_status(200)
    end
  end

  describe 'DELETE api/v1/users/:id' do
    it 'deletes the user' do
      user = create(:user)
      delete api_v1_user_path(id: user.id)
      expect(response).to have_http_status(200)
    end
  end
end
