require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  it "should get new" do
    get :new
    expect(response.status).to eq(200)
    expect(response).to render_template(:new)
  end
end