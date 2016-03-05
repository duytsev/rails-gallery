require 'rails_helper'
require 'spec_helper'

feature 'User resets password' do
  given!(:user) { @user = create(:user) }
  given!(:user2) {@user2 = create(:user, email: 'user2@exmaple.com', login: 'user2')}

  background do
    visit login_path
    fill_in 'session_email', with: @user.email
    fill_in 'session_password', with: '123123'
    click_button 'submit_login'
  end

  scenario 'with valid credentials' do
    visit user_path @user
    expect(page).to have_text @user.email
    expect(page).to have_css 'form.form-pass-reset'
    fill_in 'old_password', with: '123123'
    fill_in 'new_password', with: 'qwerty'
    fill_in 'new_password_confirmation', with: 'qwerty'
    click_button 'submit_reset'
    @user.reload
    expect(@user.valid_password?('qwerty')).to be true
  end

  scenario 'with invalid credentials' do
    visit user_path @user
    fill_in 'old_password', with: '123456'
    fill_in 'new_password', with: 'qwerty'
    fill_in 'new_password_confirmation', with: 'qwerty'
    click_button 'submit_reset'
    @user.reload
    expect(@user.valid_password?('123123')).to be true
  end
end