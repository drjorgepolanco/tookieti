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
end