require "rails_helper"

RSpec.describe UserMailer, type: :mailer do
  
  describe "account_activation" do

    before do
      @user                  = FactoryGirl.create(:user)
      @user.activation_token = User.new_token
      @mail                  = UserMailer.account_activation(@user)
    end

    it "renders the headers" do
      expect(@mail.subject).to eq("TookieTi! Activate your Account!")
      expect(@mail.to).to      eq([@user.email])
      expect(@mail.from).to    eq(["tookietiapp@gmail.com"])
    end

    it "renders the body" do
      expect(@mail.body.encoded).to match(@user.first_name)
      expect(@mail.body.encoded).to match(@user.activation_token)
      expect(@mail.body.encoded).to match(CGI::escape(@user.email))
    end
  end

  describe "password_reset" do
    
    before do
      @user = FactoryGirl.create(:user)
      @user.reset_token = User.new_token
      @mail = UserMailer.password_reset(@user)
    end

    it "renders the headers" do
      expect(@mail.subject).to eq("TookieTi! Reset your Password!")
      expect(@mail.to).to      eq([@user.email])
      expect(@mail.from).to    eq(["tookietiapp@gmail.com"])
    end

    it "renders the body" do
      expect(@mail.body.encoded).to match(@user.reset_token)
      expect(@mail.body.encoded).to match(CGI::escape(@user.email))
    end
  end

end
