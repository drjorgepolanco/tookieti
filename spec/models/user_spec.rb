require 'rails_helper'

RSpec.describe User, type: :model do
  
  before { @user = User.new(first_name:  "Julito",
                            last_name:   "Triculi", 
                            email:       "triculito@mail.com") 
         }

  subject { @user }

  it { is_expected.to respond_to(:first_name)  }
  it { is_expected.to respond_to(:last_name)   }
  it { is_expected.to respond_to(:email)       }
  it { is_expected.to be_valid                 }

  describe "when first name is not present" do
    before { @user.first_name = ""       }
    it     { is_expected.to_not be_valid }
  end

  describe "when last name is not present" do
    before { @user.last_name = ""        }
    it     { is_expected.to_not be_valid }
  end

  describe "when email is not present" do
    before { @user.email = ""            }
    it     { is_expected.to_not be_valid }
  end

  describe "when first name is too long" do
    before { @user.first_name = "x" * 41 }
    it     { is_expected.to_not be_valid }
  end

  describe "when last name is too long" do
    before { @user.last_name = "x" * 41  }
    it     { is_expected.to_not be_valid }
  end

  describe "when email is too long" do
    before { @user.email = "x" * 81      }
    it     { is_expected.to_not be_valid }
  end

  describe "when email format is not valid" do
    it "should not be valid" do
      emails = %w[tri_cu_li_to.mail tricu.lito@mail. triculito@mail,com 
                  tricu@lito_mail.com triculito@mail#com triculito@++mail.com]
      emails.each do |invalid_email|
        @user.email = invalid_email
        expect(@user).to_not be_valid
      end
    end
  end

  describe "when email format is valid" do
    it "should be valid" do
      emails = %w[triculito@mail.com Tricu_Lito@mail.COM triculi-to@mail.us
                  dr.triculito@mail.org]
      emails.each do |valid_email|
        @user.email = valid_email
        expect(@user).to be_valid
      end
    end
  end
end