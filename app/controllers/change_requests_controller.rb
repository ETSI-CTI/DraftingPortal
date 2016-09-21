class ChangeRequestsController < ApplicationController

  layout "sidebar"

  before_action :set_service

  respond_to :html, only: :index

  def index
    @change_requests = @service.find_by_user(current_user)
  end

  private

  def set_service
    @service = ChangeRequestService.new
  end

end
