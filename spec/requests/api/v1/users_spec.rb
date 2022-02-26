require 'swagger_helper'

RSpec.describe 'api/v1/users', type: :request do
  let!(:user1) { create(:user, email: 'test@1.com') }
  let!(:user2) { create(:user, email: 'test@2.com') }
  let!(:total_users) { User.all.count }

  path '/api/v1/users' do
    get('list users') do
      response(200, 'successful') do
        tags 'Users'

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test! do |response|
          resp = JSON.parse(response.body, symbolize_names: true)
          expect(resp[:data].count).to eq(total_users)
        end
      end
    end

    post('create user') do
      parameter name: :user_params, in: :body, schema: {
        properties: {
          user: {
            type: :object,
            properties: {
              fullname: { type: :string, required: true },
              email: { type: :string, required: true },
              password: { type: :string, required: true }
            }
          }
        }
      }

      response(201, 'successful') do
        tags 'Users'

        request_body = {
          user: {
            fullname: 'New User',
            email: 'new@gmail.com',
            password: 'asdasd12ad'
          }
        }

        let!(:user_params) { request_body }

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test! do |_response|
          expect(User.all.count).to eq(total_users + 1)
        end
      end
    end
  end

  path '/api/v1/users/{id}' do
    parameter name: 'id', in: :path, type: :string, description: 'User id'

    get('show user') do
      response(200, 'successful') do
        tags 'Users'

        let(:id) { user1.id }

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test! do |response|
          resp = JSON.parse(response.body, symbolize_names: true)
          expect(resp[:data][:attributes][:email]).to eq(user1.email)
        end
      end
    end

    patch('update user') do
      parameter name: :user_params, in: :body, schema: {
        properties: {
          user: {
            type: :object,
            properties: {
              fullname: { type: :string, required: false }
            }
          }
        }
      }

      response(200, 'successful') do
        tags 'Users'

        request_body = {
          user: {
            fullname: 'Updated User Name'
          }
        }

        let!(:user_params) { request_body }
        let(:id) { user1.id }

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test! do |_response|
          user1.reload
          expect(user1.fullname).to eq('Updated User Name')
        end
      end
    end

    delete('delete user') do
      response(200, 'successful') do
        tags 'Users'

        let(:id) { user1.id }

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test! do |_response|
          expect(User.all.count).to eq(total_users - 1)
        end
      end
    end
  end

  path '/api/v1/change_password' do
    parameter name: 'Authorization', in: :header, type: :string

    patch('change_password user') do
      parameter name: :user_params, in: :body, schema: {
        properties: {
          user: {
            type: :object,
            properties: {
              password: { type: :string, required: true }
            }
          }
        }
      }

      response(200, 'successful') do
        tags 'Users'

        request_body = {
          user: {
            password: 'updated password'
          }
        }

        let!(:user_params) { request_body }
        let!(:Authorization) { 'Bearer ' + JsonWebToken.encode(user_id: user1.id) }
        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
    end
  end
end
