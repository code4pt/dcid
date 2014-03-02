require 'spec_helper'

describe "User pages" do
  subject { page }

  describe "signup page," do
    before { visit signup_path }

    it { should have_title(full_title('Participar')) }
    it { should have_content('Participe') }
  end

  describe "signup," do
    before { visit signup_path }
    let(:submit) { "Criar perfil" }

    describe "with invalid information," do
      it "should not create a user" do
        expect { click_button submit }.not_to change(User, :count)
      end
    end

    describe "with valid information," do
      before do
        fill_in "Nome",                       with: "Alice Wonderland"
        fill_in "Email",                      with: "alice@wonderland.com"
        fill_in "Número do BI/CC *",          with: "100100100"
        fill_in "Palavra-chave",              with: "secret"
        fill_in "Repita a palavra-chave",     with: "secret"
      end

      it "should create a user" do
        expect { click_button submit }.to change(User, :count).by(1)
      end

      describe "after saving the user" do
        before { click_button submit }
        let(:user) { User.find_by(email: 'alice@wonderland.com') }

        it { should have_link('Sair') }
        it { should have_title(user.name) }
        it { should have_selector('div.alert.alert-success') }
      end
    end
  end

  describe "profile page," do
    let(:user) { FactoryGirl.create(:user) }
    before { visit user_path(user) }

    it { should have_content(user.name) }
    it { should have_title(user.name) }
  end

  describe "profile edit," do
    let(:user) { FactoryGirl.create(:user) }
    before { visit edit_user_path(user) }

    describe "page" do
      it { should have_content("Edite o seu perfil") }
      it { should have_title("Editar perfil") }
      it { should have_link('alterar', href: 'http://gravatar.com/emails') }
    end

    describe "with invalid information" do
      before { click_button "Guardar alterações" }

      it { should have_content('error') }
    end
  end

end
