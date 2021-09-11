# frozen_string_literal: true

module Api
  module V1
    class UsersController < BaseController
      # GET api/v1/users
      def index
        render jsonapi: User.all
      end

      # GET api/v1/users/:id
      def show
        @user = User.find(params[:id])
        render jsonapi: @user
      end

      # POST api/v1/users
      def create
        user = User.new(user_params)
        if user.save
          render jsonapi: user, status: :created, code: '201'
        else
          render jsonapi_errors: user.errors,
                 status: :unprocessable_entity, code: '422'
        end
      end

      # PUT/PATCH api/v1/users/:id
      def update
        user = User.find(params[:id])
        if user.update(user_params)
          render jsonapi: user, status: :ok, code: '200'
        else
          render jsonapi_errors: user.errors,
                 status: :unprocessable_entity, code: '422'
        end
      end

      # DELETE api/v1/users/:id
      def destroy
        user = User.find(params[:id])
        if user.destroy
          render jsonapi: user, status: :ok, code: '200'
        else
          render jsonapi_errors: user.errors,
                 status: :unprocessable_entity, code: '422'
        end
      end

      private

      def user_params
        params.require(:user).permit(:fullname, :email, :encrypted_password, :gender)
      end
    end
  end
end
