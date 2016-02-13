require 'rails_helper'
require 'spec_helper'

describe User do
  it 'should be valid' do
    expect(build(:user)).to be_valid
  end

  it 'should have email' do
    expect(build(:user, email: nil)).not_to be_valid
  end

  it 'should have login' do
    expect(build(:user, login: nil)).not_to be_valid
  end

  it 'should have password' do
    expect(build(:user, password: nil)).not_to be_valid
  end

  it 'should have password length >= 6' do
    expect(build(:user, password: '12345')).not_to be_valid
  end

  it 'should have password == password_confirmation' do
    expect(build(:user, password_confirmation: '123')).not_to be_valid
  end
end
