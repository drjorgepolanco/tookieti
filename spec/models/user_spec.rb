require 'rails_helper'

RSpec.describe User, type: :model do
  
  before do
    @user = User.new(first_name:            "Julito",
                     last_name:             "Triculi", 
                     email:                 "triculito@mail.com",
                     password:              "worldtriculi",
                     password_confirmation: "worldtriculi") 
  end

  it "should be valid" do
    expect(@user).to be_valid
  end

  describe "user first name" do
    it "should be present" do
      @user.first_name = ""
      expect(@user).to_not be_valid
    end

    it "should not be too long" do
      @user.first_name = "x" * 41
      expect(@user).to_not be_valid
    end
  end

  describe "user last name" do
    it "should be present" do
      @user.last_name = ""
      expect(@user).to_not be_valid
    end

    it "should not be too long" do
      @user.last_name = "x" * 41
      expect(@user).to_not be_valid
    end
  end

  describe "user email" do
    it "should be present" do
      @user.email = ""
      expect(@user).to_not be_valid
    end

    it "should not be too long" do
      @user.email = "x" * 82 + "@mail.com"
      expect(@user).to_not be_valid
    end

    it "should not be valid when format is not valid" do
      emails = %w[tri_cu_li_to.mail 
                  tricu.lito@mail. 
                  triculito@mail,com 
                  tricu@lito_mail.com 
                  triculito@mail#com 
                  triculito@++mail.com]

      emails.each do |invalid_email|
        @user.email = invalid_email
        expect(@user).to_not be_valid
      end
    end

    it "should be valid when format is valid" do
      emails = %w[triculito@mail.com 
                  Tricu_Lito@mail.COM 
                  triculi-to@mail.us
                  dr.triculito@mail.org]

      emails.each do |valid_email|
        @user.email = valid_email
        expect(@user).to be_valid
      end
    end

    it "should be unique" do
      duplicate_user = @user.dup
      duplicate_user.email = @user.email.upcase
      @user.save
      expect(duplicate_user).to_not be_valid
    end

    it "should be saved in lowercase characters" do
      funky_case_email = "TriCuLiTo@mAiL.coM"
      @user.email = funky_case_email
      @user.save
      expect(@user.email).to eq(funky_case_email.downcase)
    end
  end

  describe "user password" do
    it "should not be too short" do
      @user.password = @user.password_confirmation = "x" * 7
      expect(@user).to_not be_valid
    end
  end

  # describe "authenticated?" do
  #   it "should return false for a user with nil digest" do
  #     expect(@user.authenticated?('')).to be(false)
  #   end
  # end
end