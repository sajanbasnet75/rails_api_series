# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    fullname { 'Sajan' }
    email { 'Basnet' }
    password { 'asdasdasd2easd' }
    gender { 1 }
  end
end
