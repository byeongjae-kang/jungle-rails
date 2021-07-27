require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do

    before(:each) do 
      @user = User.new(
        first_name: 'first',
        last_name: 'last',
        email: 'test@test.com',
        password: 'password',
        password_confirmation: 'password'
      )
      @user.save
    end

    it "is not valid when password and password_confirmation do not match or do not exist" do
      %w[passworld nil].each do |value|
        @user.password_confirmation = value
        @user.valid?
        expect(@user.errors.full_messages).to be_present
      end
    end
    
    it "is valid when email is unique" do
      @user2 = User.new(
        first_name: 'first',
        last_name: 'last',
        email: 'test@test.com',
        password: 'password',
        password_confirmation: 'password'
      )
      @user2.save
      expect(@user2.errors.full_messages).to include("Email has already been taken")

      @user2.email = "test2@test.com"
      expect(@user2).to be_valid
    end

    it "is not valid when email, first name, or last name is not entered" do
      %w[first_name last_name email].each do |requirement|
        @user[:"#{requirement}"] = nil
        @user.valid?
        expect(@user.errors[:"#{requirement}"]).to be_present
      end
    end

    it "is not valid when password length is less than 5" do
      @user.password = "pass"
      @user.valid?
      expect(@user.errors[:password]).to be_present
    end


  end

  describe '.authenticate_with_credentials' do

    before(:each) do 
      @user = User.new(
        first_name: 'first',
        last_name: 'last',
        email: 'test@test.com',
        password: 'password',
        password_confirmation: 'password'
      )
      @user.save
    end

    it 'should pass with valid credentials' do
      @user = User.authenticate_with_credentials('test@test.com', 'password')
      expect(@user).not_to be(nil)
    end

    it 'should not pass with invalid credentials' do
      @user = User.authenticate_with_credentials('test@test.com', 'pass')
      expect(@user).to be(nil)
    end

    it 'should pass even with spaces present in email' do
      @user = User.authenticate_with_credentials('  test@test.com  ', 'password')
      expect(@user).not_to be(nil)
    end

    it 'should pass even with caps present in email' do
      @user = User.authenticate_with_credentials('tesT@tEst.com', 'password')
      expect(@user).not_to be(nil)
    end

  end

end
