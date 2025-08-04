require 'rails_helper'

RSpec.describe EventsController, type: :controller do
  let(:admin_user) { AdminUser.create!(name: 'Admin User', email: 'admin@example.com', password: 'password') }
  let!(:upcoming_event) { Event.create!(title: 'Upcoming Event', event_date: Date.current + 1.week, details: 'Details', admin_user: admin_user) }
  let!(:past_event) { Event.create!(title: 'Past Event', event_date: Date.current - 1.week, details: 'Details', admin_user: admin_user) }

  describe 'GET #index' do
    it 'assigns upcoming events to @upcoming_events' do
      get :index
      expect(assigns(:upcoming_events)).to eq([ upcoming_event ])
    end

    it 'assigns past events to @past_events' do
      get :index
      expect(assigns(:past_events)).to eq([ past_event ])
    end

    it 'renders the index template' do
      get :index
      expect(response).to render_template(:index)
    end

    context 'with search' do
      let!(:searched_event) { Event.create!(title: 'Searchable Event', event_date: Date.current + 2.weeks, details: 'Details', admin_user: admin_user) }

      it 'returns the correct upcoming events' do
        get :index, params: { search: 'Searchable' }
        expect(assigns(:upcoming_events)).to eq([ searched_event ])
      end
    end
  end

  describe 'GET #show' do
    it 'assigns the requested event to @event' do
      get :show, params: { id: upcoming_event.id }
      expect(assigns(:event)).to eq(upcoming_event)
    end

    it 'renders the show template' do
      get :show, params: { id: upcoming_event.id }
      expect(response).to render_template(:show)
    end

    context 'when the event does not exist' do
      it 'redirects to the events index' do
        get :show, params: { id: 'invalid-id' }
        expect(response).to redirect_to(events_path)
      end

      it 'sets a flash alert' do
        get :show, params: { id: 'invalid-id' }
        expect(flash[:alert]).to eq('Event not found')
      end
    end
  end
end
