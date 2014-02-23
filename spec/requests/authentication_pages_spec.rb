require 'spec_helper'

describe "Authentication," do

  subject { page }

  describe "signin page" do
    before { visit signin_path }

    it { should have_content('Entrar') }
    it { should have_title('Entrar') }
  end

  describe "signin," do
    before { visit signin_path }

    describe "with invalid information" do
      before { click_button "Entrar" }

      it { should have_title('Entrar') }
      it { should have_selector('div.alert.alert-error') }
    end

    describe "with valid information" do
      let(:user) { FactoryGirl.create(:user) }
      before do
        fill_in "Email",         with: user.email.upcase
        fill_in "Palavra-chave", with: user.password
        click_button "Sign in"
      end

      it { should have_title(user.name) }
      it { should have_link('Perfil',     href: user_path(user)) }
      it { should have_link('Sair',    href: signout_path) }
      it { should_not have_link('Entrar', href: signin_path) }
    end
  end
end