# frozen_string_literal: true

module Api
  module V1
    class UsersController < ApplicationController
      def index
        render json: User.all, code: '200', status: :ok
      end

      def show
        @user = User.find(params[:id])
        render json: @user, code: '200', status: :ok
      end

      def create
        user = User.new(user_params)
        if user.save
          render json: user, status: :created, code: '201'
        else
          render json: user.errors, status: :unprocessable_entity, code: '422'
        end
      end

      def update
        user = User.find(params[:id])
        if user.update(user_params)
          render json: user, status: :ok, code: '200'
        else
          render json: user.errors, status: :unprocessable_entity, code: '422'
        end
      end

      def destroy
        user = User.find(params[:id])
        if user.destroy
          render json: user, status: :ok, code: '200'
        else
          render json: user.errors, status: :unprocessable_entity, code: '422'
        end
      end

      private

      def user_params
        params.require(:user).permit(:fullname, :email, :encrypted_password, :gender)
      end
    end
  end
end
