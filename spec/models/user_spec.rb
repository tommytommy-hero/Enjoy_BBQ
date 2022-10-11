require "rails_helper"

RSpec.describe "Userモデルのテスト", type: :model do

  describe "バリデーションのテスト" do
    subject { user.valid? }

    let!(:other_user) { create(:user) }
    let(:user) { build(:user) }

    context "nameカラム" do
      it "空欄でないこと" do
        user.name = ""
        is_expected.to eq false
      end
      it "一意性があること" do
        user.name = other_user.name
        is_expected.to eq false
      end
    end

    context "introductionカラム" do
      it "200文字以下であること: 200文字は○" do
        user.introduction = Faker::Lorem.characters(number: 200)
        is_expected.to eq true
      end
      it "200文字以下であること: 201文字は×" do
        user.introduction = Faker::Lorem.characters(number: 201)
        is_expected.to eq false
      end
    end
  end

  describe "アソシエーションのテスト" do
    context "Recipeモデルとの関係" do
      it "1:Nとなっている" do
        expect(User.reflect_on_association(:recipes).macro).to eq :has_many
      end
    end
  end

end