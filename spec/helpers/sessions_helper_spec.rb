require 'rails_helper'

RSpec.describe "SessionsHelper", type: :helper do

  before do
    @user = FactoryGirl.create(:user)
    remember(@user)
  end
  
  describe "current user" do
    it "returns the right user when the session is nil" do
      expect(current_user).to eq(@user)
      expect(is_logged_in?).to be(true)
    end

    it "returns nil when remember digest is wrong" do
      @user.update_attribute(:remember_digest, User.digest(User.new_token))
      expect(current_user).to be(nil)
    end
  end
end
