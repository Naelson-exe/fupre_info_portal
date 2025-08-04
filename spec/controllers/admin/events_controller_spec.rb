require 'rails_helper'

RSpec.describe Admin::EventsController, type: :controller do
  let(:admin_user) { AdminUser.create!(name: 'Admin User', email: 'admin@example.com', password: 'password') }
  let!(:event) { Event.create!(title: 'Test Event', details: 'Details', event_date: Date.current, admin_user: admin_user) }

  before do
    sign_in admin_user
  end

  describe 'GET #index' do
    it 'returns a successful response' do
      get :index
      expect(response).to be_successful
    end

    it 'assigns all events to @events' do
      get :index
      expect(assigns(:events)).to eq([ event ])
    end
  end

  describe 'GET #show' do
    it 'returns a successful response' do
      get :show, params: { id: event.id }
      expect(response).to be_successful
    end
  end

  describe 'GET #new' do
    it 'returns a successful response' do
      get :new
      expect(response).to be_successful
    end
  end

  describe 'GET #edit' do
    it 'returns a successful response' do
      get :edit, params: { id: event.id }
      expect(response).to be_successful
    end
  end

  describe 'POST #create' do
    context 'with valid parameters' do
      let(:valid_params) { { event: { title: 'New Event', details: 'New Details', event_date: Date.current } } }

      it 'creates a new event' do
        expect {
          post :create, params: valid_params
        }.to change(Event, :count).by(1)
      end

      it 'redirects to the created event' do
        post :create, params: valid_params
        expect(response).to redirect_to(admin_event_path(Event.last))
      end
    end

    context 'with invalid parameters' do
      let(:invalid_params) { { event: { title: '', details: 'New Details', event_date: Date.current } } }

      it 'does not create a new event' do
        expect {
          post :create, params: invalid_params
        }.not_to change(Event, :count)
      end

      it 'renders the new template' do
        post :create, params: invalid_params
        expect(response).to render_template(:new)
      end
    end
  end

  describe 'PATCH #update' do
    context 'with valid parameters' do
      let(:valid_params) { { id: event.id, event: { title: 'Updated Event' } } }

      it 'updates the event' do
        patch :update, params: valid_params
        event.reload
        expect(event.title).to eq('Updated Event')
      end

      it 'redirects to the event' do
        patch :update, params: valid_params
        expect(response).to redirect_to(admin_event_path(event))
      end
    end

    context 'with invalid parameters' do
      let(:invalid_params) { { id: event.id, event: { title: '' } } }

      it 'does not update the event' do
        patch :update, params: invalid_params
        event.reload
        expect(event.title).not_to eq('')
      end

      it 'renders the edit template' do
        patch :update, params: invalid_params
        expect(response).to render_template(:edit)
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'deletes the event' do
      expect {
        delete :destroy, params: { id: event.id }
      }.to change(Event, :count).by(-1)
    end

    it 'redirects to the events index' do
      delete :destroy, params: { id: event.id }
      expect(response).to redirect_to(admin_events_path)
    end
  end
end
