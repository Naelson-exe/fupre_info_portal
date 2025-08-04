require 'rails_helper'

RSpec.describe HomeController, type: :controller do
  let(:admin_user) { AdminUser.create!(name: 'Admin User', email: 'admin@example.com', password: 'password') }

  describe 'GET #index' do
    let!(:featured_post) { Post.create!(title: 'Featured Post', content: 'Content', status: :published, featured: true, admin_user: admin_user, published_at: Time.current) }
    let!(:normal_post) { Post.create!(title: 'Normal Post', content: 'Content', status: :published, admin_user: admin_user, published_at: Time.current) }
    let!(:featured_event) { Event.create!(title: 'Featured Event', event_date: Date.current + 1.week, details: 'Details', featured: true, admin_user: admin_user) }
    let!(:upcoming_event) { Event.create!(title: 'Upcoming Event', event_date: Date.current + 2.weeks, details: 'Details', admin_user: admin_user) }

    it 'assigns featured posts to @featured_posts' do
      get :index
      expect(assigns(:featured_posts)).to eq([ featured_post ])
    end

    it 'assigns latest posts to @latest_posts' do
      get :index
      expect(assigns(:latest_posts)).to include(featured_post, normal_post)
    end

    it 'assigns featured events to @featured_events' do
      get :index
      expect(assigns(:featured_events)).to eq([ featured_event ])
    end

    it 'assigns upcoming events to @upcoming_events' do
      get :index
      expect(assigns(:upcoming_events)).to include(featured_event, upcoming_event)
    end

    it 'renders the index template' do
      get :index
      expect(response).to render_template(:index)
    end

    context 'when there is an error fetching data' do
      before do
        allow(Post).to receive(:where).and_raise(StandardError.new("DB error"))
      end

      it 'assigns empty arrays to all instance variables' do
        get :index
        expect(assigns(:featured_posts)).to eq([])
        expect(assigns(:featured_events)).to eq([])
        expect(assigns(:latest_posts)).to eq([])
        expect(assigns(:upcoming_events)).to eq([])
      end

      it 'sets a flash alert' do
        get :index
        expect(flash.now[:alert]).to eq('Some content could not be loaded')
      end
    end
  end
end
