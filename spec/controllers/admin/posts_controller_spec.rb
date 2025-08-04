require 'rails_helper'

RSpec.describe Admin::PostsController, type: :controller do
  let(:admin_user) { AdminUser.create!(name: 'Admin User', email: 'admin@example.com', password: 'password') }
  let(:post_obj) { Post.create!(title: 'Test Post', content: 'Content', admin_user: admin_user, status: :draft) }

  before do
    sign_in admin_user
  end

  describe 'GET #index' do
    it 'returns a successful response' do
      get :index
      expect(response).to be_successful
    end

    it 'assigns all posts to @posts' do
      get :index
      expect(assigns(:posts)).to eq([ post_obj ])
    end
  end

  describe 'GET #show' do
    it 'returns a successful response' do
      get :show, params: { id: post_obj.id }
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
      get :edit, params: { id: post_obj.id }
      expect(response).to be_successful
    end
  end

  describe 'POST #create' do
    context 'with valid parameters' do
      let(:valid_params) { { post: { title: 'New Post', content: 'New Content', status: 'draft' } } }

      it 'creates a new post' do
        expect {
          post :create, params: valid_params
        }.to change(Post, :count).by(1)
      end

      it 'redirects to the created post' do
        post :create, params: valid_params
        expect(response).to redirect_to(admin_post_path(Post.last))
      end
    end

    context 'with invalid parameters' do
      let(:invalid_params) { { post: { title: '', content: 'New Content' } } }

      it 'does not create a new post' do
        expect {
          post :create, params: invalid_params
        }.not_to change(Post, :count)
      end

      it 'renders the new template' do
        post :create, params: invalid_params
        expect(response).to render_template(:new)
      end
    end
  end

  describe 'PATCH #update' do
    context 'with valid parameters' do
      let(:valid_params) { { id: post_obj.id, post: { title: 'Updated Post', status: 'draft' } } }

      it 'updates the post' do
        patch :update, params: valid_params
        post_obj.reload
        expect(post_obj.title).to eq('Updated Post')
      end

      it 'redirects to the post' do
        patch :update, params: valid_params
        expect(response).to redirect_to(admin_post_path(post_obj))
      end
    end

    context 'with invalid parameters' do
      let(:invalid_params) { { id: post_obj.id, post: { title: '' } } }

      it 'does not update the post' do
        patch :update, params: invalid_params
        post_obj.reload
        expect(post_obj.title).not_to eq('')
      end

      it 'renders the edit template' do
        patch :update, params: invalid_params
        expect(response).to render_template(:edit)
      end
    end
  end

  describe 'DELETE #destroy' do
      it 'deletes the post' do
        post_obj
        expect {
          delete :destroy, params: { id: post_obj.id }
        }.to change(Post, :count).by(-1)
      end

    it 'redirects to the posts index' do
      delete :destroy, params: { id: post_obj.id }
      expect(response).to redirect_to(admin_posts_path)
    end
  end
end
