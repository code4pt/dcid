require 'spec_helper'

describe "Proposal" do

  subject { @proposal }
  let(:user) { FactoryGirl.create(:user) }
  before { @proposal = user.proposals.build(title: "Lorem ipsum") }

  it { should respond_to(:title) }
  it { should respond_to(:problem) }
  it { should respond_to(:solution) }
  it { should respond_to(:user_id) }
  it { should respond_to(:user) }
  its(:user) { should eq user }

  it { should be_valid }

  describe "when user_id is not present," do
    before { @proposal.user_id = nil }
    it { should_not be_valid }
  end

end
