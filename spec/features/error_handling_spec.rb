require 'rails_helper'

RSpec.feature 'Error Handling', type: :feature do
  scenario 'visiting a non-existent page' do
    visit '/non-existent-page'
    expect(page).to have_content("The page you were looking for doesn't exist.")
  end

  scenario 'visiting a post that does not exist' do
    visit '/posts/non-existent-id'
    expect(page).to have_content("The page you were looking for doesn't exist.")
  end

  scenario 'visiting an event that does not exist' do
    visit '/events/non-existent-id'
    expect(page).to have_content("The page you were looking for doesn't exist.")
  end
end
