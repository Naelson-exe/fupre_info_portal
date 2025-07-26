class PwaController < ApplicationController
  def manifest
    render file: "app/views/pwa/manifest.json.erb", content_type: "application/json"
  end
end
