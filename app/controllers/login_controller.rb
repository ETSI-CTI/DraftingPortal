class LoginController < ApplicationController

  respond_to :html, only: :login

  before_action :set_service

  def login
    user_id = params[:as]
    login_user(@service.find(user_id))

    redirect_to change_requests_path
  end

  private

  def set_service
    @service = UserService.new
  end

end
