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

    it { should have_title(user.name) }
    it { should have_content(user.name) }
  end

  describe "profile edit," do
    let(:user) { FactoryGirl.create(:user) }
    before do
      sign_in user
      visit edit_user_path(user)
    end

    describe "page" do
      it { should have_title("Editar definições") }
      it { should have_content("Edite as suas definições") }
      it { should have_link('alterar', href: 'http://gravatar.com/emails') }
    end

    describe "with valid information" do
      let(:new_name)  { "New Name" }
      let(:new_email) { "new@example.com" }
      before do
        fill_in "Nome",                   with: new_name
        fill_in "Email",                  with: new_email
        fill_in "Palavra-chave",          with: user.password
        fill_in "Repita a palavra-chave", with: user.password
        click_button "Guardar alterações"
      end

      it { should have_title(new_name) }
      it { should have_selector('div.alert.alert-success') }
      it { should have_link('Sair', href: signout_path) }
      specify { expect(user.reload.name).to  eq new_name }
      specify { expect(user.reload.email).to eq new_email }
    end

    describe "with invalid information" do
      before { click_button "Guardar alterações" }

      it { should have_selector('div.alert.alert-error') }
    end
  end

  describe "index," do
    before do
      sign_in FactoryGirl.create(:user)
      FactoryGirl.create(:user, name: "Alice Wonderland", email: "alice@wonderland.com")
      FactoryGirl.create(:user, name: "Bob Builder", email: "bob@builder.com")
      visit users_path
    end

    it { should have_title('Todos os cidadãos') }
    it { should have_content('Todos os cidadãos') }

    it "should list each user" do
      User.all.each do |user|
        expect(page).to have_selector('li', text: user.name)
      end
    end
  end

end
