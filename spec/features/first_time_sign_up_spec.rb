require 'rails_helper'
require 'spec_helper'

feature 'User registers first time' do
  scenario 'with valid credentials' do
    visit root_path
    expect(page).to have_link 'register_link'
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

  scenario 'with invalid credentials' do
    visit root_path
    click_link 'register_link'
    fill_in 'user_email', with: 'adminexample.com'
    fill_in 'user_login', with: 'admin'
    fill_in 'user_password', with: '123123'
    fill_in 'user_password_confirmation', with: '123123'
    expect{
      click_button 'submit_registration'
    }.not_to change {User.count}
  end
end