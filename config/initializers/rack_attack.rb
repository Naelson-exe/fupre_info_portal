Rack::Attack.cache.store = ActiveSupport::Cache::MemoryStore.new

Rack::Attack.throttle("logins/ip", limit: 5, period: 20.seconds) do |req|
  if req.path == "/admin/login" && req.post?
    req.ip
  end
end
