require 'rails_helper'

RSpec.describe "UsersSignups", type: :request do
  describe "signing up with invalid information" do
    it "should not work and should go back to the signup form" do
      get signup_path
      expect do
        post users_path, user: { 
          first_name:            "",
          last_name:             "miki",
          email:                 "user@triculi",
          password:              "buajaja",
          password_confirmation: "juababa" 
        }
      end.to_not change{ User.count }
      expect(response).to render_template(:new)
      expect(response.body).to include('errors')
    end
  end

  describe "signing up with valid information" do
    it "should work and should redirect to user's show view" do
      get signup_path
      expect do
        post_via_redirect users_path, user: { 
          first_name:            "Julito",
          last_name:             "Triculi",
          email:                 "triculito@gmail.com",
          password:              "worldtriculi",
          password_confirmation: "worldtriculi"
        }
      end.to change{ User.count }.from(0).to(1)
      expect(response).to render_template(:show)
      expect(flash[:success]).to_not be(nil)
    end
  end
end
