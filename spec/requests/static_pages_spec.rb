require 'spec_helper'

describe "Static pages" do
  subject { page }

  describe "Home page" do
    before { visit root_path }    

    it { should have_content('DCID') }
    it { should have_title(full_title('')) }
    it { should_not have_title('DCID |') }
  end

  describe "About page" do
    before { visit about_path }

    it { should have_content('DCID') }
    it { should have_title(full_title('Sobre nós')) }
  end
end