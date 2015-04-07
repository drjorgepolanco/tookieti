require 'rails_helper'

RSpec.describe "UsersIndices", type: :request do

  describe "index" do
    before { @user = FactoryGirl.create(:user) }

    it "should display all users index" do
      log_in_as(@user)
      get users_path
      expect(response).to render_template(:index)
      expect(response.body).to include("Cocineros")
    end
  end
end
