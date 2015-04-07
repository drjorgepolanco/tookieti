require 'rails_helper'

RSpec.describe RelationshipsController, type: :controller do

  before do
    @user       = FactoryGirl.create(:user)
    @other_user = FactoryGirl.create(:user, 
                                     first_name:      "Joselito",
                                     last_name:       "Trediente",
                                     email:           "josediente@mail.com",
                                     activated:       true,
                                     password_digest: User.digest('password'))
  end
 
  context "when creating a relationship" do
    it "should require the user to be logged in" do
      expect do
        post :create
      end.to_not change{ Relationship.count }
      expect(response).to redirect_to(login_url)
    end
  end

  context "when destroying a relationship" do

    before do
      @relationship = @user.active_relationships.create(followed_id: @other_user.id)
    end

    it "should require the user to be logged in" do
      expect do
        delete :destroy, id: @relationship
      end.to_not change{ Relationship.count }
      expect(response).to redirect_to(login_url)
    end
  end
end
