# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id         :bigint           not null, primary key
#  fullname   :string
#  email      :string
#  password   :string
#  gender     :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class UserSerializer
  include JSONAPI::Serializer
  attributes :fullname, :gender, :email

  attribute :auth_token do |user, params|
    params[:auth_token]
  end
end
