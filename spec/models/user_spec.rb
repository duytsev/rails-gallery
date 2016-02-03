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

  describe 'password update' do
    context 'matching passwords' do
      it 'updates password successfully' do
        user = create(:user)
        user.update_password(old_password: '123123',
                             new_password: '123456',
                             new_password_confirmation: '123456')
        expect(user.valid_password?('123456')).to be true
      end

      it 'fails password update, when old_password is incorrect' do
        user = create(:user)
        user.update_password(old_password: 'qwerty',
                             new_password: '123456',
                             new_password_confirmation: '123456')
        expect(user.valid_password?('123456')).to be false
      end

      it 'fails password update, when old_password is empty' do
        user = create(:user)
        user.update_password(old_password: '',
                             new_password: '123456',
                             new_password_confirmation: '123456')
        expect(user.valid_password?('123456')).to be false
      end
    end

    context 'non-matching passwords' do
      it 'fails password update, when confirmation is incorrect' do
        user = create(:user)
        user.update_password(old_password: '123123',
                             new_password: '123456',
                             new_password_confirmation: 'qwerty')
        expect(user.valid_password?('123456')).to be false
      end

      it 'fails password update, when confirmation is empty' do
        user = create(:user)
        user.update_password(old_password: '123123',
                             new_password: '123456',
                             new_password_confirmation: '')
        expect(user.valid_password?('123456')).to be false
      end
    end
  end
end
