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

      describe "after visiting another page" do
        before { click_link "DCID" }
        it { should_not have_selector('div.alert.alert-error') }
      end
    end

    describe "with valid information" do
      let(:user) { FactoryGirl.create(:user) }
      before { sign_in user }

      it { should have_title(user.name) }
      it { should have_link('Perfil',     href: user_path(user)) }
      it { should have_link('Definições', href: edit_user_path(user)) }
      it { should have_link('Sair',       href: signout_path) }
      it { should_not have_link('Entrar', href: signin_path) }

      describe "followed by signout" do
        before { click_link "Sair" }
        it { should have_link('Entrar') }
      end
    end
  end

  describe "signout," do
  end

  describe "authorization," do

    describe "for non-signed-in users" do
      let(:user) { FactoryGirl.create(:user) }

      describe "in the Users controller" do

        describe "visiting the edit page" do
          before { visit edit_user_path(user) }
          it { should have_title('Entrar') }
        end

        describe "submitting to the update action" do
          before { patch user_path(user) }
          specify { expect(response).to redirect_to(signin_path) }
        end
      end

      describe "when attempting to visit a protected page" do
        before do
          visit edit_user_path(user)
          fill_in "Email",         with: user.email
          fill_in "Palavra-chave", with: user.password
          click_button "Entrar"
        end

        describe "after signing in" do

          it "should render the desired protected page" do
            expect(page).to have_title('Editar definições')
          end
        end
      end
    end

    describe "as wrong user" do
      let(:user) { FactoryGirl.create(:user) }
      let(:wrong_user) { FactoryGirl.create(:user, email: "wrong@example.com") }
      #before { sign_in user, no_capybara: true } #FIXME this line invalidates the following tests

      describe "submitting a GET request to the Users#edit action" do
        before { get edit_user_path(wrong_user) }
        specify { expect(response.body).not_to match(full_title('Editar definições')) }
        #specify { expect(response).to redirect_to(root_url) } #FIXME redirect to user_url (public profile)
      end

      describe "submitting a PATCH request to the Users#update action" do
        before { patch user_path(wrong_user) }
        #specify { expect(response).to redirect_to(root_url) } #FIXME redirect to user_url (public profile)
      end
    end
  end

end
