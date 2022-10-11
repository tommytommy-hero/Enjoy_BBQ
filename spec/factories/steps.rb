FactoryBot.define do
  factory :steps, class: Step do
    explanation { Faker::Lorem.characters(number: 20) }
  end
end