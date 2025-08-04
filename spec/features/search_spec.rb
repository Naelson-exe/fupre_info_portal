require 'rails_helper'

RSpec.feature 'Search', type: :feature do
  let(:admin_user) { AdminUser.create!(name: 'Admin User', email: 'admin@example.com', password: 'password') }
  let!(:post1) { Post.create!(title: 'Ruby Post', content: 'This post is about Ruby.', status: :published, admin_user: admin_user, published_at: Time.current) }
  let!(:post2) { Post.create!(title: 'Rails Post', content: 'This post is about Rails.', status: :published, admin_user: admin_user, published_at: Time.current) }
  let!(:event1) { Event.create!(title: 'Ruby Conference', details: 'A conference about Ruby.', event_date: Date.current + 1.week, admin_user: admin_user) }
  let!(:event2) { Event.create!(title: 'Rails Conference', details: 'A conference about Rails.', event_date: Date.current + 2.weeks, admin_user: admin_user) }

  scenario 'searching for a term that exists in both posts and events' do
    visit root_path
    fill_in 'search', with: 'Ruby'
    click_button 'Search'

    expect(page).to have_content('Ruby Post')
    expect(page).to have_content('Ruby Conference')
    expect(page).not_to have_content('Rails Post')
    expect(page).not_to have_content('Rails Conference')
  end

  scenario 'searching for a term that only exists in posts' do
    visit root_path
    fill_in 'search', with: 'Rails Post'
    click_button 'Search'

    expect(page).to have_content('Rails Post')
    expect(page).not_to have_content('Ruby Post')
    expect(page).not_to have_content('Ruby Conference')
    expect(page).not_to have_content('Rails Conference')
  end

  scenario 'searching for a term that only exists in events' do
    visit root_path
    fill_in 'search', with: 'Rails Conference'
    click_button 'Search'

    expect(page).to have_content('Rails Conference')
    expect(page).not_to have_content('Ruby Post')
    expect(page).not_to have_content('Ruby Conference')
    expect(page).not_to have_content('Rails Post')
  end

  scenario 'searching for a term that does not exist' do
    visit root_path
    fill_in 'search', with: 'nonexistent'
    click_button 'Search'

    expect(page).to have_content('No results found.')
  end
end
