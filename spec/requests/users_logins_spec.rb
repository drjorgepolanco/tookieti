require 'rails_helper'

RSpec.describe "UsersLogins", type: :request do
  
  describe "the login process" do
    it "does not logs in with invalid information" do
      get login_path
      expect(response).to render_template(:new)
      post login_path, session: { email: "", password: "" }
      expect(response).to render_template(:new)
      expect(flash[:alert]).to_not be_nil
      get root_path
      expect(flash[:alert]).to be_nil
    end
  end
end
