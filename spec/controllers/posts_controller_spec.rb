require 'rails_helper'

RSpec.describe PostsController, type: :controller do
  let(:admin_user) { AdminUser.create!(name: 'Admin User', email: 'admin@example.com', password: 'password') }
  let!(:published_post) { Post.create!(title: 'Published Post', content: 'Content', status: :published, admin_user: admin_user, published_at: Time.current) }
  let!(:draft_post) { Post.create!(title: 'Draft Post', content: 'Content', status: :draft, admin_user: admin_user) }

  describe 'GET #index' do
    it 'assigns only published posts to @posts' do
      get :index
      expect(assigns(:posts)).to eq([ published_post ])
    end

    it 'renders the index template' do
      get :index
      expect(response).to render_template(:index)
    end

    context 'with search' do
      let!(:searched_post) { Post.create!(title: 'Searchable Title', content: 'Content', status: :published, admin_user: admin_user, published_at: Time.current) }

      it 'returns the correct posts' do
        get :index, params: { search: 'Searchable' }
        expect(assigns(:posts)).to eq([ searched_post ])
      end
    end
  end

  describe 'GET #show' do
    context 'when the post is published' do
      it 'assigns the requested post to @post' do
        get :show, params: { id: published_post.id }
        expect(assigns(:post)).to eq(published_post)
      end

      it 'renders the show template' do
        get :show, params: { id: published_post.id }
        expect(response).to render_template(:show)
      end
    end

    context 'when the post is not published' do
      it 'redirects to the posts index' do
        get :show, params: { id: draft_post.id }
        expect(response).to redirect_to(posts_path)
      end

      it 'sets a flash alert' do
        get :show, params: { id: draft_post.id }
        expect(flash[:alert]).to eq('Memo not found')
      end
    end

    context 'when the post does not exist' do
      it 'redirects to the posts index' do
        get :show, params: { id: 'invalid-id' }
        expect(response).to redirect_to(posts_path)
      end

      it 'sets a flash alert' do
        get :show, params: { id: 'invalid-id' }
        expect(flash[:alert]).to eq('Memo not found')
      end
    end
  end
end
