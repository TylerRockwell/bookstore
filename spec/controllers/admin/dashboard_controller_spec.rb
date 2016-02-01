require 'rails_helper'

RSpec.describe Admin::DashboardController, type: :controller do
  let!(:sign_in_admin){ sign_in create(:admin) }
  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

end
