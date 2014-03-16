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

  describe "profiles index," do
    let(:user) { FactoryGirl.create(:user) }
    before(:each) do
      sign_in user
      visit users_path
    end

    it { should have_title('Cidadãos') }
    it { should have_content('Todos os cidadãos') }

    describe "pagination" do

      before(:all) { 30.times { FactoryGirl.create(:user) } }
      after(:all)  { User.delete_all }

      it { should have_selector('div.pagination') }

      it "should list each user" do
        User.paginate(page: 1).each do |user|
          expect(page).to have_selector('li', text: user.name)
        end
      end
    end
  end

#TODO FIXME
=begin
  describe "delete links," do
      it { should_not have_link('Apagar') }

      describe "as an admin user" do
        let(:admin) { FactoryGirl.create(:admin) }
        before do
          sign_in admin
          visit users_path
        end

        it { should have_link('Apagar', href: user_path(User.first)) }
        it "should be able to delete another user" do
          expect do
            click_link('Apagar', match: :first)
          end.to change(User, :count).by(-1)
        end
        it { should_not have_link('Apagar', href: user_path(admin)) }
      end
  end
=end

end
