require 'spec_helper'

describe "User pages" do
  subject { page }

  describe "signup page" do
    before { visit signup_path }
    it { should have_title(full_title('Participar')) }
    it { should have_content('Participe') }    
  end

  describe "signup" do
    before { visit signup_path }
    let(:submit) { "Criar o meu perfil" }

    describe "with invalid information" do
      it "should not create a user" do
        expect { click_button submit }.not_to change(User, :count)
      end
    end

    describe "with valid information" do
      before do
        fill_in "Name",           with: "Alice Wonderland"
        fill_in "Email",          with: "alice@wonderland.com"
        fill_in "Citizen Number", with: "100100100"
        fill_in "Password",       with: "secret"
        fill_in "Confirmation",   with: "secret"
      end

      it "should create a user" do
        expect { click_button submit }.to change(User, :count).by(1)
      end
    end
  end

  describe "profile page" do
    let(:user) { FactoryGirl.create(:user) }
    before { visit user_path(user) }

    it { should have_content(user.name) }
    it { should have_title(user.name) }
  end

end
