require 'spec_helper'

describe User do
  subject { @user }

  before { @user = User.new(name: "Alice Wonderland", email: "alice@wonderland.com", citizen_number:"123123123") }  

  it { should respond_to(:name) }
  it { should respond_to(:email) }
  it { should respond_to(:citizen_number) }
  it { should be_valid }

  describe "when name is not present" do
    before { @user.name = " " }
    it { should_not be_valid }
  end

  describe "when email is not present" do
    before { @user.email = " " }
    it { should_not be_valid }
  end

  describe "when citizen number is not present" do
    before { @user.citizen_number = " " }
    it { should_not be_valid }
  end
end
