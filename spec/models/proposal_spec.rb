require 'spec_helper'

describe "Proposal" do

  subject { @proposal }
  let(:user) { FactoryGirl.create(:user) }
  before { @proposal = user.proposals.build(title: "A title", problem: "A problem", solution: "A solution") }

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

  describe "with blank title" do
    before { @proposal.title = " " }
    it { should_not be_valid }
  end

  describe "with blank problem" do
    before { @proposal.problem = " " }
    it { should_not be_valid }
  end

  describe "with blank solution" do
    before { @proposal.solution = " " }
    it { should_not be_valid }
  end

  describe "with title that is too long" do
    before { @proposal.title = "a" * 81 }
    it { should_not be_valid }
  end

  describe "with problem that is too long" do
    before { @proposal.problem = "a" * 401 }
    it { should_not be_valid }
  end

  describe "with solution that is too long" do
    before { @proposal.solution = "a" * 701 }
    it { should_not be_valid }
  end

end
