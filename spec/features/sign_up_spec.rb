require 'rails_helper'
require 'spec_helper'

feature 'User registers first time' do
  scenario 'with valid credentials' do
    visit root_path
    click_link 'register_link'
    fill_in 'user_email', with: 'admin@example.com'
    fill_in 'user_login', with: 'admin'
    fill_in 'user_password', with: '123123'
    fill_in 'user_password_confirmation', with: '123123'
    expect{
      click_button 'submit_registration'
    }.to change {User.count}.by(1)
    expect(User.first.admin).to be true
  end
end

feature 'Admin registers new user' do
  given!(:user) { @admin = create(:user, :admin) }

  background do
    visit login_path
    fill_in 'session_email', with: @admin.email
    fill_in 'session_password', with: '123123'
    click_button 'submit_login'
  end

  scenario 'with valid credentials' do
    visit users_path
    click_link 'add_user'
    fill_in 'user_email', with: 'user1@example.com'
    fill_in 'user_login', with: 'user1'
    fill_in 'user_password', with: '123123'
    fill_in 'user_password_confirmation', with: '123123'
    expect{
      click_button 'submit_registration'
    }.to change {User.count}.by(1)
  end

  scenario 'with invalid email' do
    visit users_path
    click_link 'add_user'
    fill_in 'user_email', with: 'user1example.com'
    fill_in 'user_login', with: 'user1'
    fill_in 'user_password', with: '123123'
    fill_in 'user_password_confirmation', with: '123123'
    expect{
      click_button 'submit_registration'
    }.not_to change {User.count}
  end

  scenario 'with invalid password'
  scenario 'with invalid password confirmation'
end