require 'spec_helper'

describe "User pages" do
  subject { page }

  describe "signup page" do
    before { visit signup_path }

    it { should have_title(full_title('Participar')) }
    it { should have_content('Participe') }    
  end
end
