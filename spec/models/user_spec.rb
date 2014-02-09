require 'spec_helper'

describe User do
  subject { @user }

  before { @user = User.new(name: "Alice Wonderland", email: "alice@wonderland.com",
                            citizen_number:"123123123") }  

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

  describe "when name is too long" do
    before { @user.name = "a" * 51 }
    it { should_not be_valid }
  end

  describe "when email format is invalid" do
    it "should be invalid" do
      addresses = %w[user@foo,com user_at_foo.org example.user@foo. foo@bar_baz.com
                      foo@bar+baz.com]
      addresses.each do |invalid_address|
        @user.email = invalid_address
        expect(@user).not_to be_valid
      end
    end
  end

  describe "when email format is valid" do
    it "should be valid" do
      addresses = %w[user@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn]
      addresses.each do |valid_address|
        @user.email = valid_address
        expect(@user).to be_valid
      end
    end
  end

  describe "when citizen number format is invalid" do
    it "should be invalid" do
      numbers = %w[03773392 a.word 123x567]
      numbers.each do |invalid_numbers|
        @user.citizen_number = invalid_numbers
        expect(@user).not_to be_valid
      end
    end
  end

  describe "when citizen number format is valid" do
    it "should be valid" do
      numbers = %w[13773392]
      numbers.each do |valid_numbers|
        @user.citizen_number = valid_numbers
        expect(@user).to be_valid
      end
    end
  end

  describe "when email address is already taken" do
    before do
      user_with_same_email = @user.dup
      user_with_same_email.email = @user.email.upcase
      user_with_same_email.save
    end
    it { should_not be_valid }
  end

end
