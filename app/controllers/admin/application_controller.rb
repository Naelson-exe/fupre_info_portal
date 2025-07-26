class Admin::ApplicationController < ApplicationController
  include AdminAuthenticatable
  layout "admin"
end
