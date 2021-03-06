FactoryGirl.define do
  factory :user do
    username              { Faker::Internet.user_name }
    first_name            { Faker::Name.first_name }
    last_name             { Faker::Name.last_name }
    email                 { Faker::Internet.email }
    password              { 'seshook123' }
    password_confirmation { 'seshook123' }
  end

  factory :admin, parent: :user do
    after(:build) { |u| u.admin! }
  end

  factory :superadmin, parent: :user do
    after(:build) { |u| u.superadmin! }
  end

  factory :user_with_avatar, parent: :user do
    after(:build) { |u| u.avatar = File.open('spec/fixtures/placeholder_avatar.png') }
  end

  factory :facebook_user, parent: :user do
    facebook_id { SecureRandom.random_number(1_000_000) }
  end
end
