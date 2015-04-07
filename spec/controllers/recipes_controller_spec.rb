require 'rails_helper'

RSpec.describe RecipesController, type: :controller do

  before do
    @user       = FactoryGirl.create(:user)
    @other_user = FactoryGirl.create(:user, 
                                     first_name:      "Joselito",
                                     last_name:       "Trediente",
                                     email:           "josediente@mail.com",
                                     activated:       true,
                                     password_digest: User.digest('password'))
    @recipe     = @user.recipes.create(title: "Berengenas a la Parmesana",
                                       description: "Lorem ipsum dolor sit amet",
                                       steps: "Lorem ipsum dolor sit amet",
                                       prep_time: 45)
  end

  context "when the user is not logged in" do
    it "should redirect the create action" do
      expect do
        post :create, recipes: {
          title: "Berengenas a la Parmesana",
          description: "Lorem ipsum dolor sit amet, consectetur adipisicing.",
          steps: "Lorem ipsum dolor sit amet, consectetur adipisicing elit. ",
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

  context "when the recipe belongs to other user" do
    it "should redirect the destroy action" do
      log_in_as(@other_user)
      expect do
        delete :destroy, id: @recipe
      end.to_not change{ Recipe.count }
      expect(response).to redirect_to(recipes_url)
    end
  end
end