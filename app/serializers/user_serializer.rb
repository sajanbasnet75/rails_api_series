# frozen_string_literal: true

class UserSerializer
  include JSONAPI::Serializer
  attributes :fullname, :gender, :email
end
