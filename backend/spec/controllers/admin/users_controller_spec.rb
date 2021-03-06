require 'rails_helper'

describe Admin::UsersController do
  let(:user)  { create(:user) }

  before { sign_in current_admin }

  describe "GET index" do
    it "assigns all users as @users" do
      get :index
      expect(assigns(:users)).to eq([user, current_admin])
    end
  end

  describe "GET new" do
    it "assigns a new user as @user" do
      get :new
      expect(assigns(:user)).to be_a_new(User)
    end
  end

  describe "GET edit" do
    it "assigns the requested user as @user" do
      get :edit, {id: user.id}
      expect(assigns(:user)).to eq(user)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new User" do
        expect {
          post :create, {user: attributes_for(:user)}
        }.to change(User, :count).by(1)
      end

      it "assigns a newly created user as @user" do
        post :create, {user: attributes_for(:user)}
        expect(assigns(:user)).to be_a(User)
        expect(assigns(:user)).to be_persisted
      end

      it "redirects to the created user" do
        post :create, {user: attributes_for(:user)}
        expect(response).to redirect_to admin_users_url
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved user as @user" do
        post :create, {user: {email: ''}}
        expect(assigns(:user)).to be_a_new(User)
      end

      it "re-renders the 'new' template" do
        post :create, {user: {email: ''}}
        expect(response).to render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      let(:new_attributes) { {email: 'newmail@mail.com'} }

      it "updates the requested user" do
        put :update, {id: user.id, user: new_attributes}
        user.reload
        expect(user.email).to eq('newmail@mail.com')
      end

      it "assigns the requested user as @user" do
        put :update, {id: user.id, user: new_attributes}
        expect(assigns(:user)).to eq(user)
      end

      it "redirects to the user" do
        put :update, {id: user.id, user: new_attributes}
        expect(response).to redirect_to admin_users_url
      end
    end

    describe "with invalid params" do
      it "assigns the user as @user" do
        put :update, {id: user.id, user: {email: ''}}
        expect(assigns(:user)).to eq(user)
      end

      it "re-renders the 'edit' template" do
        put :update, {id: user.id, user: {email: ''}}
        expect(response).to render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested user" do
      user
      expect {
        delete :destroy, {id: user.id}
      }.to change(User, :count).by(-1)
    end

    it "redirects to the user list" do
      delete :destroy, {id: user.id}
      expect(response).to redirect_to(admin_users_url)
    end
  end
end
