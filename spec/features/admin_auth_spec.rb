require "rails_helper"

RSpec.configure do |config|
  config.include Warden::Test::Helpers
  config.before :suite do
    Warden.test_mode!
  end
end

describe "Admin Authentication", type: :feature do
  let(:admin_user) { FactoryBot.create(:admin_user) }

  before :each do
    # Create admin user before each test
    admin_user
  end

  def login_as(user)
    visit admin_login_path
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "Login"
  end

  describe "login" do
    it "allows admin to login with correct credentials" do
      visit admin_login_path
      fill_in "Email", with: admin_user.email
      fill_in "Password", with: admin_user.password
      click_button "Login"

      # Debugging output
      puts "Current path: #{page.current_path}"
      puts "Response body: #{page.body}"
      
      expect(page).to have_current_path(admin_root_path)
      expect(page).to have_content("Welcome, Admin User")
    end

    it "shows error with incorrect credentials" do
      visit admin_login_path
      fill_in "Email", with: admin_user.email
      fill_in "Password", with: "wrongpassword"
      click_button "Login"

      expect(page).to have_content("Invalid email or password")
    end
  end

  describe "logout" do
    before do
      login_as(admin_user)
    end

    it "allows admin to logout" do
      visit admin_root_path
      click_link "Logout"

      expect(page).to have_current_path(admin_login_path)
      expect(page).to have_content("Logged out successfully")
    end
  end

  describe "unauthorized access" do
    it "redirects to login page when not authenticated" do
      visit admin_root_path
      expect(page).to have_current_path(admin_login_path)
      expect(page).to have_content("Please log in")
    end
  end
end
