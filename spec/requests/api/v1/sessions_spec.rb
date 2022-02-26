require 'swagger_helper'

RSpec.describe 'api/v1/sessions', type: :request do
  let!(:user1) { create(:user, email: 'test@1.com') }

  path '/api/v1/login' do
    parameter name: :login_params, in: :body, schema: {
      properties: {
        user: {
          type: :object,
          properties: {
            email: { type: :string, required: true },
            password: { type: :string, required: true }
          }
        }
      }
    }

    post('login session') do
      response(200, 'successful') do
        tags 'Sessions'

        let!(:user1) { create(:user, email: 'test@1.com') }
        request_body = {}

        before do |_example|
          request_body = {
            user: {
              email: user1.email,
              password: user1.password
            }
          }
        end

        let!(:login_params) { request_body }

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test! do |response|
          resp = JSON.parse(response.body, symbolize_names: true)
          token = JsonWebToken.encode(user_id: user1.id)
          expect(resp[:data][:attributes][:auth_token]).to eq(token)
        end
      end
    end
  end
end
