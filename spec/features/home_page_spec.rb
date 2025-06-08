require "rails_helper"

describe "Home page", type: :feature do
  it "displays welcome message" do
    visit root_path
    expect(page).to have_content("Welcome to FUPRE Information Portal")
  end
end
