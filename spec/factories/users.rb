FactoryBot.define do
  factory :user do
    name { 'test_user' }
    email { 'sample@example.com' }
    password { 'password' }
  end
end
