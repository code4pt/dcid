require 'spec_helper'

describe 'Proposal,' do
  let(:user) { FactoryGirl.create(:user) }
  before do
    # This code is not idiomatically correct.
    @proposal = Proposal.new(title: "Lorem ipsum", user_id: user.id)
  end

  subject { @proposal }

  it { should respond_to(:title) }
  it { should respond_to(:problem) }
  it { should respond_to(:solution) }
  it { should respond_to(:user_id) }
end
