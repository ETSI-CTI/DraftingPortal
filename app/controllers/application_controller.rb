class ApplicationController < ActionController::Base
  include Concerns::Login

  protect_from_forgery with: :exception

  layout "default"
end
