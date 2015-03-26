require 'rails_helper'

RSpec.describe PagesController, type: :controller do

  it "should render home" do
    get :home
    expect(response.status).to eq(200)
    expect(response).to render_template(:home)
  end

  it "should get about" do
    get :about
    expect(response.status).to eq(200)
    expect(response).to render_template(:about)
  end
end