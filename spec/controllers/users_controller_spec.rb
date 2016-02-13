require 'rails_helper'
require 'spec_helper'

describe UsersController do
  describe 'GET #index' do
    context 'not authenticated' do
      it 'renders login page' do
        get :index
        expect(response).to redirect_to login_path
      end
    end

    context 'simple user' do
      before do
        @user = create(:user)
      end

      it 'renders root page' do
        login_user @user
        get :index
        expect(response).to redirect_to root_path
      end
    end

    context 'admin' do
      before do
        @admin = create(:user, :admin, email: 'admin1@example.com', login: 'admin1')
      end

      it 'renders index page' do
        login_user @admin
        get :index
        expect(assigns(:users)).to eq([@admin])
      end
    end
  end

  describe 'GET #show' do
    render_views

    before do
      @user = create(:user)
    end

    context 'not authenticated' do
      it 'renders login page' do
        get :show, id: @user.id
        expect(response).to redirect_to login_path
      end
    end

    context 'simple user' do
      it 'renders root page' do
        login_user @user
        get :show, id: @user.id
        expect(assigns(:user)).to eq(@user)
        expect(response.body.to_s).not_to have_css '.form-pass-reset'
      end
    end

    context 'admin' do
      before do
        @admin = create(:user, :admin, email: 'admin1@example.com', login: 'admin1')
      end

      it 'renders index page' do
        login_user @admin
        get :show, id: @user.id
        expect(assigns(:user)).to eq(@user)
        expect(response.body.to_s).to have_css '.form-pass-reset'
      end
    end
  end

  describe 'GET #new' do
    context 'not authenticated' do
      render_views
      before do
        @user = create(:user)
      end

      it 'renders login page' do
        get :new
        expect(response).to redirect_to login_path
      end
    end

    context 'simple user' do
      before do
        @user = create(:user)
      end

      it 'renders root page' do
        login_user @user
        get :new
        expect(response).to redirect_to root_path
      end
    end

    context 'admin' do
      before do
        @admin = create(:user, :admin, email: 'admin1@example.com', login: 'admin1')
      end

      it 'renders index page' do
        login_user @admin
        get :new
        expect(response).to have_http_status(:ok)
      end
    end
  end

  describe 'POST create' do
    context 'not authenticated' do
      before do
        @user = create(:user)
      end

      it 'does not create a new user' do
        expect {
          post :create, user: FactoryGirl.attributes_for(:user)
        }.not_to change { User.count }
      end
    end

    context 'simple user' do
      before do
        @user = create(:user)
      end
      it 'does not create a new user' do
        login_user @user
        expect {
          post :create, user: FactoryGirl.attributes_for(:user, email: 'user1@example.com', login: 'user1')
        }.not_to change { User.count }
      end
    end

    context 'admin' do
      before do
        @admin = create(:user, :admin, email: 'admin1@example.com', login: 'admin1')
      end

      it 'creates a new user' do
        login_user @admin
        expect {
          post :create, user: FactoryGirl.attributes_for(:user, email: 'user1@example.com', login: 'user1')
        }.to change { User.count }.by(1)
      end
    end
  end

  describe 'PUT reset_password' do
    before do
      skip 'rewrite as feature spec'
      @user = create(:user)
    end

    context 'not authenticated' do
      it 'does not reset password' do
        put :reset_password, id: @user.id,
                             old_password: '123123',
                             new_password: '123456',
                             new_password_confirmation: '123456'
        expect(response).to have_http_status(302)
        expect(@user.valid_password?('123123')).to be true
      end
    end

    context 'simple user' do
      it 'does not reset password' do
        login_user @user
        put :reset_password, id: @user,
            old_password: '123123',
            new_password: '123456',
            new_password_confirmation: '123456'
        expect(response).to have_http_status(302)
        expect(@user.valid_password?('123123')).to be true
      end
    end

    context 'admin' do
      before do
        @admin = create(:user, :admin, email: 'admin1@example.com', login: 'admin1')
      end

      it 'resets password' do
        login_user @admin
        visit user_path @user
        put :reset_password, id: @user,
            old_password: '123123',
            new_password: '123456',
            new_password_confirmation: '123456'
        @user.reload
        expect(@user.valid_password?('123456')).to be true
      end
    end
  end

  describe 'DELETE destroy' do
    before do
      @user = create(:user)
    end

    context 'not authenticated' do
      it 'does not delete user' do
        expect {
          delete :destroy, id: @user
        }.to_not change { User.count }
      end
    end

    context 'simple user' do
      it 'does not delete user' do
        login_user @user
        expect {
          delete :destroy, id: @user
        }.to_not change { User.count }
      end
    end

    context 'admin' do
      before do
        @admin = create(:user, :admin, email: 'admin1@example.com', login: 'admin1')
      end

      it 'delete user' do
        login_user @admin
        expect {
          delete :destroy, id: @user
        }.to change { User.count }.by(-1)
      end
    end
  end
end