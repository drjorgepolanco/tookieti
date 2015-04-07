require 'rails_helper'

RSpec.describe Recipe, type: :model do
  before do
    @user = FactoryGirl.create(:user)
    @recipe = @user.recipes.build(title: "Berengenas a la Parmesana",
                                  description: "Lorem ipsum dolor sit amet, consectetur adipisicing elit. Corporis nihil alias dolores sed voluptatibus dolorem neque? Mollitia doloremque placeat, deleniti aliquam unde dolore quo explicabo! Doloribus, dolorem! Aut, explicabo blanditiis.",
                                  steps: "Lorem ipsum dolor sit amet, consectetur adipisicing elit. A, beatae, voluptates. Necessitatibus sapiente quaerat laboriosam ullam, accusamus fuga mollitia accusantium aut, aspernatur culpa minus alias dolor natus esse facere! Labore?",
                                  prep_time: 45)
  end

  it "should be valid" do
    expect(@recipe).to be_valid
  end

  it "should belong to a user" do
    @recipe.user_id = nil
    expect(@recipe).to_not be_valid
  end

  describe "title" do
    context "when it is not present" do
      it "should not be valid" do
        @recipe.title = nil
        expect(@recipe).to_not be_valid
      end
    end

    context "when it is too long" do
      it "should not be valid" do
        @recipe.title = "a" * 26
        expect(@recipe).to_not be_valid
      end
    end
  end

  describe "description" do
    context "when it is not present" do
      it "should not be valid" do
        @recipe.description = nil
        expect(@recipe).to_not be_valid
      end
    end
  end

  describe "steps" do
    context "when it is not present" do
      it "should not be valid" do
        @recipe.steps = nil
        expect(@recipe).to_not be_valid
      end
    end
  end

  describe "prep_time" do
    context "when it is not present" do
      it "should not be valid" do
        @recipe.prep_time = nil
        expect(@recipe).to_not be_valid
      end
    end
  end
end
