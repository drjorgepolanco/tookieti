require 'rails_helper'

RSpec.describe "UsersEdits", type: :request do
  before { @user = FactoryGirl.create(:user) }

  it "is not successful with wrong information" do
    get edit_user_path(@user)
    expect(response).to render_template(:edit)
    patch user_path(@user), user: { name:            "",
                                    email:           "julito@wrong.",
                                    password:            "triculito",
                                    password_confirmation: "triculi"}
    expect(response).to render_template(:edit)
  end

  it "is successful with the correct information" do
    get edit_user_path(@user)
    expect(response).to render_template(:edit)
    first_name = "Julito"
    last_name  = "Triculi"
    email      = "triculito@gmail.com"
    patch user_path(@user), user: { name:          first_name,
                                    last_name:      last_name,
                                    email:              email,
                                    password:              "",
                                    password_confirmation: ""}
    expect(flash).to_not be(nil)
    expect(response).to redirect_to(@user)
    @user.reload
    expect(first_name).to eq(@user.first_name) 
    expect(last_name).to  eq(@user.last_name) 
    expect(email).to      eq(@user.email) 
  end
end
