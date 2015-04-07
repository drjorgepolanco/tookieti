require 'rails_helper'

RSpec.describe RecipesController, type: :controller do

  before do
    @user = FactoryGirl.create(:user)
    @recipe = @user.recipes.create(title: "Berengenas a la Parmesana",
                                  description: "Lorem ipsum dolor sit amet, consectetur adipisicing elit. Corporis nihil alias dolores sed voluptatibus dolorem neque? Mollitia doloremque placeat, deleniti aliquam unde dolore quo explicabo! Doloribus, dolorem! Aut, explicabo blanditiis.",
                                  steps: "Lorem ipsum dolor sit amet, consectetur adipisicing elit. A, beatae, voluptates. Necessitatibus sapiente quaerat laboriosam ullam, accusamus fuga mollitia accusantium aut, aspernatur culpa minus alias dolor natus esse facere! Labore?",
                                  prep_time: 45)
  end

  context "when the user is not logged in" do
    it "should redirect the create action" do
      expect do
        post :create, recipes: {
          title: "Berengenas a la Parmesana",
          description: "Lorem ipsum dolor sit amet, consectetur adipisicing elit. Corporis nihil alias dolores sed voluptatibus dolorem neque? Mollitia doloremque placeat, deleniti aliquam unde dolore quo explicabo! Doloribus, dolorem! Aut, explicabo blanditiis.",
          steps: "Lorem ipsum dolor sit amet, consectetur adipisicing elit. A, beatae, voluptates. Necessitatibus sapiente quaerat laboriosam ullam, accusamus fuga mollitia accusantium aut, aspernatur culpa minus alias dolor natus esse facere! Labore?",
          prep_time: 45
        }
      end.to_not change{ Recipe.count }
      expect(response).to redirect_to(login_url)
    end

    it "should redirect the destroy action" do
      expect do
        delete :destroy, id: @recipe
      end.to_not change{ Recipe.count }
      expect(response).to redirect_to(login_url)
    end
  end
end