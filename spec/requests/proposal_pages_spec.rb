require 'spec_helper'

describe "Proposal pages" do

  subject { page }

  let(:user) { FactoryGirl.create(:user) }
  before { sign_in user }

end
