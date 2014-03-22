require 'spec_helper'

describe "User" do

  subject { @user }
  before { @user = User.new(name: "Alice Wonderland", email: "alice@wonderland.com", citizen_number:"100100100",
                            password: "secret", password_confirmation: "secret") }

  it { should respond_to(:name) }
  it { should respond_to(:email) }
  it { should respond_to(:citizen_number) }
  it { should respond_to(:password_digest) }
  it { should respond_to(:password) }
  it { should respond_to(:password_confirmation) }
  it { should respond_to(:authenticate) }
  it { should respond_to(:remember_token) }
  it { should respond_to(:admin) }
  it { should respond_to(:proposals) }
  it { should be_valid }
  it { should_not be_admin }

  describe "with admin attribute set to 'true'" do
    before do
      @user.save!
      @user.toggle!(:admin)
    end

    it { should be_admin }
  end

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


  describe "validation," do

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

    describe "when citizen number format is not valid" do
      it "should not be valid" do
        numbers = %w[03773392 1234 a1234567]
        numbers.each do |valid_numbers|
          @user.citizen_number = valid_numbers
          expect(@user).not_to be_valid
        end
      end
    end

    describe "when citizen number is already taken" do
      before do
        user_copy = @user.dup
        user_copy.password_digest = "#UserPassw0rdEncrypted!"
        user_copy.save
      end
      it { should_not be_valid }
    end
  end


  describe "authentication," do

    describe "and password is not present" do
      before do
        @user = User.new(name: "Example User", email: "user@example.com",
                         password: " ", password_confirmation: " ")
      end
      it { should_not be_valid }
    end

    describe "and password doesn't match confirmation" do
      before { @user.password_confirmation = "mismatch" }
      it { should_not be_valid }
    end

    describe "and password is too short" do
      before { @user.password = @user.password_confirmation = "a" * 5 }
      it { should be_invalid }
    end

    describe "and return value of authenticate method," do
      before { @user.save }
      let(:found_user) { User.find_by(email: @user.email) }

      describe "has valid password" do
        it { should eq found_user.authenticate(@user.password) }
      end

      describe "has invalid password" do
        let(:user_for_invalid_password) { found_user.authenticate("invalid") }

        it { should_not eq user_for_invalid_password }
        specify { expect(user_for_invalid_password).to be_false }
      end
    end

    describe "session cookie" do
      before { @user.save }
      its(:remember_token) { should_not be_blank }  # it { expect(@user.remember_token).not_to be_blank }
    end
  end

  describe "proposal associations," do

    before { @user.save }
    let!(:older_proposal) do
      FactoryGirl.create(:proposal, user: @user, created_at: 1.day.ago)
    end
    let!(:newer_proposal) do
      FactoryGirl.create(:proposal, user: @user, created_at: 1.hour.ago)
    end

    it "should have the right proposals in the right order" do
      expect(@user.proposals.to_a).to eq [newer_proposal, older_proposal]
    end

    it "should destroy associated proposals" do
      proposals = @user.proposals.to_a
      @user.destroy
      expect(proposals).not_to be_empty
      proposals.each do |proposal|
        expect(Proposal.where(id: proposal.id)).to be_empty
      end
    end
  end

end
