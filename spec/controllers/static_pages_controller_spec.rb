# frozen_string_literal: true

require 'rails_helper'

RSpec.describe StaticPagesController, type: :controller do
  describe 'static_pages#index action' do
    it 'should display the page successfully' do
      get :index
      expect(response).to have_http_status(:success)
    end
  end
end
