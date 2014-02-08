require 'spec_helper'

describe "Static pages" do

  describe "Home page" do

    it "should have the content 'DCID'" do
      visit root_path
      expect(page).to have_content('DCID')
    end    
  end

  describe "About page" do
    
    it "should have the content 'DCID'" do
      visit about_path
      expect(page).to have_content('DCID')
    end
    it "should have the base title plus a custom title" do
      visit about_path
      expect(page).to have_title('DCID | Sobre nós')
    end    
  end
end