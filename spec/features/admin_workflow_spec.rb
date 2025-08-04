require 'rails_helper'

RSpec.feature 'Admin Workflow', type: :feature do
  let!(:admin_user) { AdminUser.create!(name: 'Admin User', email: 'admin@example.com', password: 'password') }

  before do
    visit admin_login_path
    fill_in 'Email', with: admin_user.email
    fill_in 'Password', with: 'password'
    click_button 'Login'
  end

  scenario 'creating a new post' do
    visit admin_root_path
    click_link 'Manage Memos'
    click_link 'New Memo'

    fill_in 'Title', with: 'New Admin Post'
    fill_in_rich_text_area 'post_content', with: 'This is the content of the new admin post.'
    select 'published', from: 'Status'
    click_button 'Create Memo'

    expect(page).to have_content('Post was successfully created.')
    expect(page).to have_content('New Admin Post')
  end

  scenario 'editing an existing post' do
    post = Post.create!(title: 'Original Post', content: 'Original content', admin_user: admin_user, status: :draft)

    visit admin_post_path(post)
    click_link 'Edit'

    fill_in 'Title', with: 'Updated Admin Post'
    fill_in_rich_text_area 'post_content', with: 'Updated content.'
    click_button 'Update Memo'

    expect(page).to have_content('Memo was successfully updated.')
    expect(page).to have_content('Updated Admin Post')
  end
end
