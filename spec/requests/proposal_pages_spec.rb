require 'spec_helper'

describe "Proposal pages" do

  subject { page }

  let(:user) { FactoryGirl.create(:user) }
  before { sign_in user }

  describe "proposal creation," do
    before { visit root_path }

    describe "with invalid information" do

      it "should not create a proposal" do
        expect { click_button "Submeter" }.not_to change(Proposal, :count)
      end

      describe "error messages" do
        before { click_button "Submeter" }
        it { should have_content('error') }
      end
    end

    describe "with valid information" do

      before { fill_in 'proposal_title', with: "Lorem ipsum" }
      it "should create a proposal" do
        expect { click_button "Submeter" }.to change(Proposal, :count).by(1)
      end
    end
  end
end
