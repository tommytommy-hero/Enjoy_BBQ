require "rails_helper"

RSpec.describe "Recipeモデルのテスト", type: :model do
  describe "バリデーションのテスト" do
    subject {recipe.valid? }

    let(:user) {create(:user) }
    let(:genre) {create(:genre) }
    let!(:recipe) { build(:recipe, user_id: user.id) }

    context "nameカラム" do
      it "空欄でないこと" do
        recipe.name = ""
        is_expected.to eq false
      end
    end

    context "introductionカラム" do
      it "空欄でないこと" do
        recipe.introduction = ""
        is_expected.to eq false
      end
      it "200文字以内であること:200文字は○" do
        recipe.introduction = Faker::Lorem.characters(number: 200)
        is_expected.to eq true
      end
      it "200文字以内であること:201文字は×" do
        recipe.introduction = Faker::Lorem.characters(number: 201)
        is_expected.to eq false
      end
    end
  end
  describe "アソシエーションのテスト" do
    context "Userモデルとの関係" do
      it "N:1となっている" do
        expect(Recipe.reflect_on_association(:user).macro).to eq :belongs_to
      end
    end
    context "Ingredientモデルとの関係" do
      it "1:Nとなっている" do
        expect(Recipe.reflect_on_association(:ingredients).macro).to eq :has_many
      end
    end
    context "Stepモデルとの関係" do
      it "1:Nとなっている" do
        expect(Recipe.reflect_on_association(:steps).macro).to eq :has_many
      end
    end
  end
end