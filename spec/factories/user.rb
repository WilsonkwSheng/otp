# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    sequence :email do |n|
      "user-#{n}-#{Time.now.to_i.to_s(32)}@google.com"
    end
    password { "password1" }
    name { Faker::Name.first_name }
    phone_number { "+6010#{Faker::Number.number(digits: 7)}" }
  end
end
