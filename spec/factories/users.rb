FactoryBot.define do
  factory :user do
    fullname { 'MyString' }
    email { 'MyString' }
    encrypted_password { 'MyString' }
    gender { 1 }
  end
end
