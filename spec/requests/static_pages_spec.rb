require 'spec_helper'

describe "Static pages" do

  describe "Home page" do

    it "should have the content 'Home page nah'" do
      visit home_path
      expect(page).to have_content('Home page nah')
    end
  end
end