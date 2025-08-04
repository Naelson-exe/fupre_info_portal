module AuthenticationHelpers
  def sign_in(user)
    session[:admin_user_id] = user.id
    session[:last_seen_at] = Time.current
  end
end

RSpec.configure do |config|
  config.include AuthenticationHelpers, type: :controller
  config.include Warden::Test::Helpers
end
