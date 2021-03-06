require 'rails_helper'

describe Admin::ApplicationsController do
  let(:admin) { nil }

  before { sign_in admin }

  context 'as an admin' do
    let(:admin) { current_admin }

    it 'unauthorize access' do
      get :index
      expect(response).to redirect_to(admin_dashboard_path)
    end
  end

  context 'as an admin' do
    let(:admin) { create(:superadmin) }

    it 'renders admin layout' do
      get :index
      is_expected.to render_with_layout(:application)
    end
  end
end
