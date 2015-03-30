require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  before do 
    @user       = FactoryGirl.create(:user,
                                     admin:           true)
    @other_user = FactoryGirl.create(:user, 
                                     first_name:      "Joselito",
                                     last_name:       "Trediente",
                                     email:           "josediente@mail.com",
                                     password_digest: User.digest('password'))
  end

  it "should get new" do
    get :new
    expect(response.status).to eq(200)
    expect(response).to render_template(:new)
  end

  context "when user is not logged in" do
    it "should redirect index" do
      get :index
      expect(response).to redirect_to(login_path)
    end

    it "should redirect edit" do
      get :edit, id: @user
      expect(flash[:alert]).to_not be_empty
    end

    it "should redirect update" do
      patch :update, id: @user, user: { 
        first_name: @user.first_name,
        last_name:  @user.last_name,
        email:      @user.email
      }
      expect(flash[:alert]).to_not be_empty
      expect(response).to redirect_to(login_path)
    end
  end

  context "when user tries to log in as a wrong user" do
    it "should redirect edit" do
      log_in_as(@other_user)
      get :edit, id: @user
      expect(flash).to be_empty
      expect(response).to redirect_to(root_path)
    end

    it "should redirect update" do
      log_in_as(@other_user)
      patch :update, id: @user, user: { 
        first_name: @user.first_name,
        last_name:  @user.last_name,
        email:      @user.email 
      }
      expect(flash).to be_empty
      expect(response).to redirect_to(root_path)
    end

    it "should not allow the admin attribute to be edited via the web" do
      log_in_as(@other_user)
      expect(@other_user.admin?).to be(false)
      patch :update, id: @other_user, user: {
        password:              "password",
        password_confirmation: "password",
        admin:                 true
      }
      expect(@other_user.reload.admin?).to be(false)
    end
  end

  describe "destroying users" do
    context "when is not logged in" do
      it "should redirect to login" do
        expect do
          delete :destroy, id: @user
        end.to_not change{ User.count }
        expect(response).to redirect_to(login_url)
      end
    end

    context "when user is not admin" do
      it "should redirect to root" do
        log_in_as(@other_user)
        expect do
          delete :destroy, id: @user
        end.to_not change{ User.count }
        expect(response).to redirect_to(root_url)
      end
    end    
  end
end