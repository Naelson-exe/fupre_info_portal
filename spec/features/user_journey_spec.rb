require 'rails_helper'

RSpec.feature 'User Journey', type: :feature do
  let(:admin_user) { AdminUser.create!(name: 'Admin User', email: 'admin@example.com', password: 'password') }
  let!(:post1) { Post.create!(title: 'First Post', content: 'Content about Ruby', status: :published, admin_user: admin_user, published_at: Time.current) }
  let!(:post2) { Post.create!(title: 'Second Post', content: 'Content about Rails', status: :published, admin_user: admin_user, published_at: Time.current) }
  let!(:event1) { Event.create!(title: 'Ruby Conference', details: 'A conference about Ruby', event_date: Date.current + 1.week, admin_user: admin_user) }

  scenario 'browsing the site' do
    visit root_path

    expect(page).to have_content('Welcome to FUPRE Information Portal')

    click_link 'Memos'
    expect(page).to have_content('First Post')
    expect(page).to have_content('Second Post')

    click_link 'First Post'
    expect(page).to have_content('Content about Ruby')

    visit events_path
    expect(page).to have_content('Ruby Conference')
  end

  scenario 'searching for content' do
    visit search_path
    fill_in 'query', with: 'Ruby'
    click_button 'Search'

    expect(page).to have_content('First Post')
    expect(page).to have_content('Ruby Conference')
    expect(page).not_to have_content('Second Post')
  end
end
