require 'rails_helper'

RSpec.describe "ApplicationHelper", type: :helper do
  describe "full title helper" do
    it "returns the full title of the given page" do
      expect(helper.full_title).to eq("CocinitApp!")
      expect(helper.full_title("Nosotros")).to eq("Nosotros | CocinitApp!")
    end
  end
end