FactoryBot.define do
  factory :user do
    fullname { 'Sajan' }
    email { 'Basnet' }
    encrypted_password { 'asdasdasd2easd' }
    gender { 1 }
  end
end
