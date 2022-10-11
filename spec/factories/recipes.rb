FactoryBot.define do
  factory :recipe, class: Recipe do
    name { Faker::Lorem.characters(number: 5) }
    introduction { Faker::Lorem.characters(number: 20) }

    trait :with_ingredients do
      after(:build) do |recipe|
        ingredient = build(:ingredients)
        recipe.ingredients << ingredient
      end
    end

    trait :with_steps do
      after(:build) do |recipe|
        step = build(:steps)
        recipe.steps << step
      end
    end
    genre
  end
end