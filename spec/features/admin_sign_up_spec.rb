require 'rails_helper'
require 'spec_helper'

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
    expect(current_path).to eq new_user_path
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
    expect(current_path).to eq new_user_path
    fill_in 'user_email', with: 'user1example.com'
    fill_in 'user_login', with: 'user1'
    fill_in 'user_password', with: '123123'
    fill_in 'user_password_confirmation', with: '123123'
    expect{
      click_button 'submit_registration'
    }.not_to change {User.count}
  end

  scenario 'with invalid password' do
    visit users_path
    click_link 'add_user'
    expect(current_path).to eq new_user_path
    fill_in 'user_email', with: 'user1example.com'
    fill_in 'user_login', with: 'user1'
    fill_in 'user_password', with: '12312'
    fill_in 'user_password_confirmation', with: '12312'
    expect{
      click_button 'submit_registration'
    }.not_to change {User.count}
  end

  scenario 'with invalid password confirmation' do
    visit users_path
    click_link 'add_user'
    expect(current_path).to eq new_user_path
    fill_in 'user_email', with: 'user1example.com'
    fill_in 'user_login', with: 'user1'
    fill_in 'user_password', with: '123123'
    fill_in 'user_password_confirmation', with: 'qwerty'
    expect{
      click_button 'submit_registration'
    }.not_to change {User.count}
  end
end