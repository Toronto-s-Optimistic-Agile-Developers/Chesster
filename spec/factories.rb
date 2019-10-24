# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    sequence :email do |n|
      "dummyEmail#{n}@gmail.com"
    end
    password { 'secretPassword' }
    password_confirmation { 'secretPassword' }
    username { 'OptimisticToad' }
  end

  factory :game do
    username { 'OptimisticToad' }
    player_id { 1 }
    white_id { 2 }
    black_id { 3 }
    association :user
  end
end
