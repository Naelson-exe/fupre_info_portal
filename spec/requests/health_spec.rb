require 'rails_helper'

RSpec.describe 'Health check', type: :request do
  it 'returns a successful response' do
    get '/health'
    expect(response).to have_http_status(:ok)
  end
end
