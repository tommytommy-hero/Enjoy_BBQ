FactoryBot.define do
  factory :ingredients, class: Ingredient do
    name { Faker::Lorem.characters(number: 5) }
    amount { Faker::Lorem.characters(number: 5) }
  end
end