require 'spec_helper'

describe User do
  subject { @user }

  before { @user = User.new(name: "Alice Wonderland", email: "alice@wonderland.com", citizen_number:"123123123") }  

  it { should respond_to(:name) }
  it { should respond_to(:email) }
  it { should respond_to(:citizen_number) }
end
