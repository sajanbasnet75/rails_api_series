# frozen_string_literal: true

module Api
  module V1
    class UsersController < BaseController
      def index
        render jsonapi: User.all
      end

      def show
        @user = User.find(params[:id])
        render jsonapi: @user
      end

      def create
        user = User.new(user_params)
        if user.save
          render jsonapi: user, status: :created, code: '201'
        else
          render jsonapi_errors: user.errors,
                 status: :unprocessable_entity, code: '422'
        end
      end

      def update
        user = User.find(params[:id])
        if user.update(user_params)
          render jsonapi: user, status: :ok, code: '200'
        else
          render jsonapi_errors: user.errors,
                 status: :unprocessable_entity, code: '422'
        end
      end

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
