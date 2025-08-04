require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:admin_user) { AdminUser.create!(name: 'Admin User', email: 'admin@example.com', password: 'password') }

  describe 'validations' do
    it 'is valid with a title, content, and status' do
      post = Post.new(
        title: 'Test Post',
        content: 'This is the content of the test post.',
        status: :draft,
        admin_user: admin_user
      )
      expect(post).to be_valid
    end

    it 'is invalid without a title' do
      post = Post.new(content: 'No title here', admin_user: admin_user)
      expect(post).not_to be_valid
      expect(post.errors[:title]).to include("can't be blank")
    end

    it 'is invalid with a title shorter than 3 characters' do
      post = Post.new(title: 'Hi', content: 'Short title', admin_user: admin_user)
      expect(post).not_to be_valid
      expect(post.errors[:title]).to include('is too short (minimum is 3 characters)')
    end

    it 'is invalid without content' do
      post = Post.new(title: 'Valid Title', admin_user: admin_user)
      expect(post).not_to be_valid
      expect(post.errors[:content]).to include("can't be blank")
    end

    it 'is invalid with a summary longer than 500 characters' do
      post = Post.new(
        title: 'Valid Title',
        content: 'Valid content',
        summary: 'a' * 501,
        admin_user: admin_user
      )
      expect(post).not_to be_valid
      expect(post.errors[:summary]).to include('is too long (maximum is 500 characters)')
    end

    it 'is invalid with an invalid status' do
      expect { Post.new(status: :invalid_status) }.to raise_error(ArgumentError)
    end
  end

  describe 'scopes' do
    let!(:post1) { Post.create!(title: 'First Post', content: 'Content about Ruby', summary: 'A post on Ruby', status: :draft, admin_user: admin_user).tap { |p| p.update!(status: :published) } }
    let!(:post2) { Post.create!(title: 'Second Post', content: 'Content about Rails', summary: 'A post on Rails', status: :draft, admin_user: admin_user) }
    let!(:post3) { Post.create!(title: 'Third Post', content: 'Another post about Ruby', summary: 'More Ruby content', status: :draft, admin_user: admin_user).tap { |p| p.update!(status: :published) } }

    it 'filters by title with with_title' do
      expect(Post.with_title('First')).to contain_exactly(post1)
    end

    it 'filters by content with with_content' do
      expect(Post.with_content('Rails')).to contain_exactly(post2)
    end

    it 'filters by summary with with_summary' do
      expect(Post.with_summary('Rails')).to contain_exactly(post2)
    end

    it 'filters by status with with_status' do
      expect(Post.with_status(:draft)).to contain_exactly(post2)
    end

    it 'returns only published posts with published scope' do
      expect(Post.published).to contain_exactly(post1, post3)
    end

    it 'returns only draft posts with draft scope' do
      expect(Post.draft).to contain_exactly(post2)
    end

    it 'orders by creation date with recent scope' do
      expect(Post.recent).to eq([ post3, post2, post1 ])
    end

    it 'searches across title, content, and summary with search scope' do
      expect(Post.search('Ruby')).to contain_exactly(post1, post3)
      expect(Post.search('Rails')).to contain_exactly(post2)
    end
  end

  describe 'callbacks' do
    it 'sets published_at when a post is published' do
      post = Post.create!(title: 'New Post', content: 'Content', status: :draft, admin_user: admin_user)
      expect(post.published_at).to be_nil
      post.update(status: :published)
      expect(post.published_at).to be_within(1.second).of(Time.current)
    end
  end

  describe '#formatted_date' do
    it 'returns the formatted published_at date if available' do
      published_at = Time.current - 2.days
      post = Post.new(published_at: published_at)
      expect(post.formatted_date).to eq(published_at.strftime('%B %d, %Y'))
    end

    it 'returns the formatted created_at date if published_at is nil' do
      created_at = Time.current - 3.days
      post = Post.new(created_at: created_at)
      expect(post.formatted_date).to eq(created_at.strftime('%B %d, %Y'))
    end
  end

  describe '#excerpt' do
    it 'returns the summary if present' do
      post = Post.new(summary: 'This is a custom summary.')
      expect(post.excerpt).to eq('This is a custom summary.')
    end

    it 'returns a truncated content if summary is not present' do
      post = Post.new(content: 'This is a long content that needs to be truncated for the excerpt.')
      expect(post.excerpt(20)).to eq('This is a long...')
    end
  end
end
