# frozen_string_literal: true

module Api
  module V1
    class UsersController < BaseController
      before_action :authenticate_request!, only: [:change_password]

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

    # UPDATE api/v1/change_password
    def change_password
      if params[:user][:password] && @current_user.update(password: params[:user][:password])
        render jsonapi: @current_user, status: :ok, code: '200'
      else
        render jsonapi_errors: @current_user.errors, status: :unprocessable_entity, code: '422'
      end
    end

      private

      def user_params
        params.require(:user).permit(:fullname, :email, :password, :gender)
      end
    end
  end
end
