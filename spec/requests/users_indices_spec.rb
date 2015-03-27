require 'rails_helper'

RSpec.describe "UsersIndices", type: :request do

  describe "index" do
    before { @user = FactoryGirl.create(:user) }

    it "should display all users with pagination" do
      log_in_as(@user)
      get users_path
      expect(response).to render_template(:index)
      expect(response.body).to include("Users")
      # assert_select 'div.pagination-centered'
      # User.paginate(page: 1).each do |user|
      #   expect(page).to have_link(full_name(user), href: user_path(user))
      # end
    end
  end
end
