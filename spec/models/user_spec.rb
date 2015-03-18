require 'rails_helper'

RSpec.describe User, type: :model do
  
  before do
    @user = User.new(first_name:            "Julito",
                     last_name:             "Triculi", 
                     email:                 "triculito@mail.com",
                     password:              "worldtriculi",
                     password_confirmation: "worldtriculi") 
  end

  subject { @user }

  it { is_expected.to respond_to(:first_name)            }
  it { is_expected.to respond_to(:last_name)             }
  it { is_expected.to respond_to(:email)                 }
  it { is_expected.to respond_to(:password_digest)       }
  it { is_expected.to respond_to(:password)              }
  it { is_expected.to respond_to(:password_confirmation) }
  it { is_expected.to be_valid                           }

  describe "fist name" do
    describe "when is not present" do
      before { @user.first_name = ""       }
      it     { is_expected.to_not be_valid }
    end

    describe "when is too long" do
      before { @user.first_name = "x" * 41 }
      it     { is_expected.to_not be_valid }
    end
  end

  describe "last name" do
    describe "when is not present" do
      before { @user.last_name = ""        }
      it     { is_expected.to_not be_valid }
    end

    describe "when is too long" do
      before { @user.last_name = "x" * 41  }
      it     { is_expected.to_not be_valid }
    end
  end

  describe "email" do
    describe "when is not present" do
      before { @user.email = ""            }
      it     { is_expected.to_not be_valid }
    end

    describe "when is too short" do
      before { @user.email = "aaaa"        }
      it     { is_expected.to_not be_valid }
    end

    describe "when is too long" do
      before { @user.email = "x" * 81      }
      it     { is_expected.to_not be_valid }
    end

    describe "when format is not valid" do
      it "should not be valid" do
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
    end

    describe "when format is valid" do
      it "should be valid" do
        emails = %w[triculito@mail.com 
                    Tricu_Lito@mail.COM 
                    triculi-to@mail.us
                    dr.triculito@mail.org]
        emails.each do |valid_email|
          @user.email = valid_email
          expect(@user).to be_valid
        end
      end
    end

    describe "when address is taken" do
      before do
        user_duplicated_email       = @user.dup
        user_duplicated_email.email = @user.email.upcase
        user_duplicated_email.save
      end
      it { is_expected.to_not be_valid }
    end

    describe "when is provided with mixed case" do
      let(:mixed_email) { "TricuLi@mAiL.coM" }

      it "should be downcased before it is saved" do
        @user.email = mixed_email
        @user.save
        expect(@user.reload.email).to eq(mixed_email.downcase)
      end
    end
  end

  describe "when password is too short" do
    before { @user.password = @user.password_confirmation = "triculi" }
    it     { is_expected.to_not be_valid }
  end
end