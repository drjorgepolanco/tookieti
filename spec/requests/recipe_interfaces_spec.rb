require 'rails_helper'

RSpec.describe "RecipeInterfaces", type: :request do
  
  before do
    @user = FactoryGirl.create(:user)
    log_in_as(@user)
    visit recipes_path
    assert_selector("div.pagination-centered")
  end

  context "when submission is invalid" do
    it "should not create a new recipe" do
      expect do
      post recipes_path, recipe: {
        title:       "",
        description: "",
        steps:       "Lorem ipsum dolor sit amet",
        prep_time:   45,
        picture:     "recipe.jpg"
      }
    end.to_not change{ Recipe.count }
    expect(flash).to_not be(nil)
    end
  end

  context "when submission is valid" do
    it "should create a new recipe" do
      expect do
      post recipes_path, recipe: {
                         title:       "Berengenas a la Parmesana",
                         description: "Lorem ipsum dolor sit amet",
                         steps:       "Lorem ipsum dolor sit amet",
                         prep_time:   45,
                         picture:     "recipe.jpg"
      }
    end.to change{ Recipe.count }.by(1)
    expect(response).to redirect_to(recipes_path)
    follow_redirect!
    expect(response.body).to include("Berengenas")
    end
  end
end
