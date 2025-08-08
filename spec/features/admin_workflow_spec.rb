require 'rails_helper'

RSpec.feature 'Admin Workflow', type: :feature do
  let!(:admin_user) { AdminUser.create!(name: 'Admin User', email: 'admin@example.com', password: 'password') }

  before do
    visit admin_login_path
    fill_in 'Email', with: admin_user.email
    fill_in 'Password', with: 'password'
    click_button 'Login'
  end

  scenario 'creating a new post', js: true do
    visit admin_root_path
    within('.sidebar') do
      click_link 'Manage Memos'
    end
    click_link 'New Memo'

    fill_in 'Title', with: 'New Admin Post'
    find(:css, "trix-editor[id=post_content]", wait: 5).click.set('This is the content of the new admin post.')
    select 'Published', from: 'Status'
    click_button 'Save Memo'

    expect(page).to have_content('Post was successfully created.')
    expect(page).to have_content('New Admin Post')
  end

  scenario 'editing an existing post', js: true do
    post = Post.create!(title: 'Original Post', content: 'Original content', admin_user: admin_user, status: :draft)

    visit admin_posts_path
    click_link 'Edit'

    fill_in 'Title', with: 'Updated Admin Post'
    find(:css, "trix-editor[id=post_content]", wait: 5).click.set('Updated content.')
    click_button 'Save Memo'

    expect(page).to have_content('Memo was successfully updated.')
    expect(page).to have_content('Updated Admin Post')
  end
end
